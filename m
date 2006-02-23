Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWBWTrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWBWTrj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWBWTri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:47:38 -0500
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:46992 "EHLO
	smtpq1.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1751768AbWBWTri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:47:38 -0500
Message-ID: <43FE1171.80305@keyaccess.nl>
Date: Thu, 23 Feb 2006 20:48:01 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>	 <1140707358.4672.67.camel@laptopd505.fenrus.org>	 <200602231700.36333.ak@suse.de>	 <1140713001.4672.73.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>	 <43FE0B9A.40209@keyaccess.nl> <1140723289.4952.10.camel@localhost.localdomain>
In-Reply-To: <1140723289.4952.10.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Iau, 2006-02-23 at 20:23 +0100, Rene Herman wrote:

>> Does 16MB still work? Gets the kernel out of the old ZONE_DMA. I suppose 
>> not many people are really using that anyway anymore these days, but if 
>> no downsides maybe?
> 
> Certainly the PAE kernel might as well do that and the AMD64 if it
> doesn't already. There are complications however getting above 16MB
> because 16bit protected mode (and maybe the BIOS helpers - I need to
> check that) can't hit it.

INT 15/AH=0x87 (move from low to high) on a 386+ should work, according 
to the documentation I have... Is PM16 used anywhere?

> We also used to have people DMAing into static kernel buffers in older
> days but hopefully that habit is now dead and gone because modules
> sorted most of it out.

Good method to flush out any possible remaining users :-)

Rene.

