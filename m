Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWHFCah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWHFCah (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 22:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWHFCah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 22:30:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:43443 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751460AbWHFCag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 22:30:36 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: fix one case of stuck dwarf2 unwinder
Date: Sun, 6 Aug 2006 04:30:06 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Jan Beulich <jbeulich@novell.com>, Dave Jones <davej@redhat.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>
References: <200608051640_MC3-1-C736-44E2@compuserve.com>
In-Reply-To: <200608051640_MC3-1-C736-44E2@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608060430.06935.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> --- 2.6.18-rc3-d4.orig/include/asm-i386/unwind.h
> +++ 2.6.18-rc3-d4/include/asm-i386/unwind.h
> @@ -71,13 +71,14 @@ extern asmlinkage int arch_unwind_init_r
>                                                                            void *arg),
>                                                 void *arg);
>  
> +extern void stext(void); /* real start of kernel text */

Can't you use _stext[] from asm/sections.h?

-Andi
