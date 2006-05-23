Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWEWOit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWEWOit (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWEWOit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:38:49 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:24500
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1750892AbWEWOis
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:38:48 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [stable][patch] x86_64: fix number of ia32 syscalls
Date: Tue, 23 May 2006 16:33:50 +0200
User-Agent: KMail/1.9.1
References: <200605221701_MC3-1-C081-B4B3@compuserve.com>
In-Reply-To: <200605221701_MC3-1-C081-B4B3@compuserve.com>
Cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Dave Jones <davej@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
       linux-stable <stable@kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605231633.51186.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 May 2006 22:59, you wrote:
> Recent discussions about whether to print a message about unimplemented
> ia32 syscalls on x86_64 have missed the real bug: the number of ia32
> syscalls is wrong in 2.6.16.  Fixing that kills the message.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> 
> --- 2.6.16.17-64.orig/include/asm-x86_64/ia32_unistd.h
> +++ 2.6.16.17-64/include/asm-x86_64/ia32_unistd.h
> @@ -317,6 +317,6 @@
>  #define __NR_ia32_ppoll			309
>  #define __NR_ia32_unshare		310
>  
> -#define IA32_NR_syscalls 315	/* must be > than biggest syscall! */

Maybe fix the comment so this is more clear, too?
/* must be biggest syscall + 1 */
