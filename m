Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWBMRix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWBMRix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWBMRix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:38:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31678 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932105AbWBMRix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:38:53 -0500
Date: Mon, 13 Feb 2006 09:35:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>
Subject: Re: 2.6.16-rc3: more regressions
In-Reply-To: <20060213170945.GB6137@stusta.de>
Message-ID: <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
 <20060213170945.GB6137@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Feb 2006, Adrian Bunk wrote:
>
> I have some regressions [1] on my list that weren't metioned by Andrew:
> 
> Subject    : Xorg freezes 2.6.16-rc1
> References : http://lkml.org/lkml/2006/1/26/97
> Submitter  : Mauro Tassinari <mtassinari@cmanet.it>
> Status     : unknown

For this one, it would be interesting to see more info about the working 
setup. Notably

 - what modules are loaded by the time X is running
 - any differences in 'dmesg' output from 2.6.15 to 16-rc1 (PCI allocation 
   issues should show up there)

I don't see any real differences in the radeonfb driver, for example 
(there's some trivial cleanup, including things like speeling fixums, but 
nothing that looks remotely likely).

Of course, in a perfect world, we'd have serial or network console 
output.. X crashes are nastier than most, if only because the console is 
mostly gone.

		Linus
