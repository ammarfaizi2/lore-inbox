Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264482AbUEDT0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbUEDT0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 15:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbUEDT0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 15:26:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:53186 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264482AbUEDT0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 15:26:33 -0400
Date: Tue, 4 May 2004 12:26:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH] mxcsr patch for i386 & x86-64
In-Reply-To: <Pine.LNX.4.58.0405041201440.3271@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0405041225080.3271@ppc970.osdl.org>
References: <E305A4AFB7947540BC487567B5449BA802CA7BEC@scsmsx402.sc.intel.com>
 <Pine.LNX.4.58.0405041201440.3271@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 May 2004, Linus Torvalds wrote:
> 
> Right now you export a function that does just a simple mask operation, 
> and quite frankly, that just seems to make it less clear what the code is 
> doing. So who not get rid of that "set_fpu_mxcsr()" function, and just 
> replace all the "0xffbf" uses with "mxcsr_feature_mask"?

I also note that the x86-64 version of has "mxcsr" as "unsigned short" in 
set_fpu_mxcsr(). I'd have expected these changes to make it possible to 
have feature bits in the high 16 bits too, no?

		Linus
