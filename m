Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbVHVWXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbVHVWXt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbVHVWXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:23:47 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:54152 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751380AbVHVWXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:23:14 -0400
Date: Mon, 22 Aug 2005 11:29:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Adam Litke <agl@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Cleanup line-wrapping in pgtable.h
Message-ID: <20050822092913.GB11888@elf.ucw.cz>
References: <1124300739.3139.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124300739.3139.16.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The line-wrapping in most of the include/asm/pgtable.h pte test/set
> macros looks horrible in my 80 column terminal.  The following "test the
> waters" patch is how I would like to see them laid out.  I realize that
> the braces don't adhere to CodingStyle but the advantage is (when taking
> wrapping into account) that the code takes up no additional space.  How
> do people feel about making this change?  Any better suggestions?  I
> personally wouldn't like a lone closing brace like normal functions
> because of the extra lines eaten.  I volunteer to patch up the other
> architectures if we reach a consensus.

I'm afraid that original version looks better than new one...
								Pavel


> Signed-off-by: Adam Litke <agl@us.ibm.com>
> 
>  pgtable.h |   51 ++++++++++++++++++++++++++++++++++-----------------
>  1 files changed, 34 insertions(+), 17 deletions(-)
> diff -upN reference/include/asm-i386/pgtable.h current/include/asm-i386/pgtable.h
> --- reference/include/asm-i386/pgtable.h
> +++ current/include/asm-i386/pgtable.h
> @@ -215,28 +215,45 @@ extern unsigned long pg0[];
>   * The following only work if pte_present() is true.
>   * Undefined behaviour if not..
>   */
> -static inline int pte_user(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
> -static inline int pte_read(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
> -static inline int pte_dirty(pte_t pte)		{ return (pte).pte_low & _PAGE_DIRTY; }
> -static inline int pte_young(pte_t pte)		{ return (pte).pte_low & _PAGE_ACCESSED; }
> -static inline int pte_write(pte_t pte)		{ return (pte).pte_low & _PAGE_RW; }
> +static inline int pte_user(pte_t pte)
> +	{ return (pte).pte_low & _PAGE_USER; }
> +static inline int pte_read(pte_t pte)
> +	{ return (pte).pte_low & _PAGE_USER; }
> +static inline int pte_dirty(pte_t pte)
> +	{ return (pte).pte_low & _PAGE_DIRTY; }
> +static inline int pte_young(pte_t pte)
> +	{ return (pte).pte_low & _PAGE_ACCESSED; }
> +static inline int pte_write(pte_t pte)
> +	{ return (pte).pte_low & _PAGE_RW; }
>  
>  /*
>   * The following only works if pte_present() is not true.
>   */
> -static inline int pte_file(pte_t pte)		{ return (pte).pte_low & _PAGE_FILE; }
> +static inline int pte_file(pte_t pte)
> +	{ return (pte).pte_low & _PAGE_FILE; }
>  
> -static inline pte_t pte_rdprotect(pte_t pte)	{ (pte).pte_low &= ~_PAGE_USER; return pte; }
> -static inline pte_t pte_exprotect(pte_t pte)	{ (pte).pte_low &= ~_PAGE_USER; return pte; }
> -static inline pte_t pte_mkclean(pte_t pte)	{ (pte).pte_low &= ~_PAGE_DIRTY; return pte; }
> -static inline pte_t pte_mkold(pte_t pte)	{ (pte).pte_low &= ~_PAGE_ACCESSED; return pte; }
> -static inline pte_t pte_wrprotect(pte_t pte)	{ (pte).pte_low &= ~_PAGE_RW; return pte; }
> -static inline pte_t pte_mkread(pte_t pte)	{ (pte).pte_low |= _PAGE_USER; return pte; }
> -static inline pte_t pte_mkexec(pte_t pte)	{ (pte).pte_low |= _PAGE_USER; return pte; }
> -static inline pte_t pte_mkdirty(pte_t pte)	{ (pte).pte_low |= _PAGE_DIRTY; return pte; }
> -static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
> -static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
> -static inline pte_t pte_mkhuge(pte_t pte)	{ (pte).pte_low |= _PAGE_PRESENT | _PAGE_PSE; return pte; }
> +static inline pte_t pte_rdprotect(pte_t pte)
> +	{ (pte).pte_low &= ~_PAGE_USER; return pte; }
> +static inline pte_t pte_exprotect(pte_t pte)
> +	{ (pte).pte_low &= ~_PAGE_USER; return pte; }
> +static inline pte_t pte_mkclean(pte_t pte)
> +	{ (pte).pte_low &= ~_PAGE_DIRTY; return pte; }
> +static inline pte_t pte_mkold(pte_t pte)
> +	{ (pte).pte_low &= ~_PAGE_ACCESSED; return pte; }
> +static inline pte_t pte_wrprotect(pte_t pte)
> +	{ (pte).pte_low &= ~_PAGE_RW; return pte; }
> +static inline pte_t pte_mkread(pte_t pte)
> +	{ (pte).pte_low |= _PAGE_USER; return pte; }
> +static inline pte_t pte_mkexec(pte_t pte)
> +	{ (pte).pte_low |= _PAGE_USER; return pte; }
> +static inline pte_t pte_mkdirty(pte_t pte)
> +	{ (pte).pte_low |= _PAGE_DIRTY; return pte; }
> +static inline pte_t pte_mkyoung(pte_t pte)
> +	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
> +static inline pte_t pte_mkwrite(pte_t pte)
> +	{ (pte).pte_low |= _PAGE_RW; return pte; }
> +static inline pte_t pte_mkhuge(pte_t pte)
> +	{ (pte).pte_low |= _PAGE_PRESENT | _PAGE_PSE; return pte; }
>  
>  #ifdef CONFIG_X86_PAE
>  # include <asm/pgtable-3level.h>

-- 
if you have sharp zaurus hardware you don't need... you know my address
