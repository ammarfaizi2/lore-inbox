Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264618AbUEDVJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264618AbUEDVJq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 17:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264628AbUEDVI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 17:08:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41192 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264614AbUEDVH5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 17:07:57 -0400
Message-ID: <40980620.1040405@pobox.com>
Date: Tue, 04 May 2004 17:07:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Kamble, Nitin A" <nitin.a.kamble@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH] mxcsr patch for i386 & x86-64
References: <E305A4AFB7947540BC487567B5449BA802CA7BEC@scsmsx402.sc.intel.com> <Pine.LNX.4.58.0405041201440.3271@ppc970.osdl.org> <Pine.LNX.4.58.0405041225080.3271@ppc970.osdl.org> <Pine.LNX.4.58.0405041322570.3271@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405041322570.3271@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> --- 1.19/arch/i386/kernel/i387.c	Tue Feb  3 21:30:39 2004
> +++ edited/arch/i386/kernel/i387.c	Tue May  4 13:15:10 2004
> @@ -24,6 +25,21 @@
>  #define HAVE_HWFP 1
>  #endif
>  
> +static unsigned long mxcsr_feature_mask = 0xffffffff;

> --- 1.10/arch/x86_64/kernel/i387.c	Fri Jan 23 12:17:58 2004
> +++ edited/arch/x86_64/kernel/i387.c	Tue May  4 13:07:35 2004
> @@ -24,6 +24,18 @@
>  #include <asm/ptrace.h>
>  #include <asm/uaccess.h>
>  
> +unsigned long mxcsr_feature_mask = 0xffffffff;
> +


Minor/dumb question:  Is the above intentional?

Would be nice to have them the same for consistency if nothing else. 
i386 and x86-64 common code gets pasted and #include'd all the time.

	Jeff



