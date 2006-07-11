Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWGKT3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWGKT3p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWGKT3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:29:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10459 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751201AbWGKT3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:29:44 -0400
Date: Tue, 11 Jul 2006 12:29:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olh@suse.de>
cc: "H. Peter Anvin" <hpa@zytor.com>, Jeff Garzik <jeff@garzik.org>,
       Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
In-Reply-To: <20060711191548.GA17585@suse.de>
Message-ID: <Pine.LNX.4.64.0607111226320.5623@g5.osdl.org>
References: <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org>
 <20060711171624.GA16554@suse.de> <44B3DEA0.3010106@zytor.com>
 <20060711173030.GA16693@suse.de> <44B3E40E.2090306@zytor.com>
 <20060711180126.GB16869@suse.de> <44B3E814.3060004@zytor.com>
 <20060711181055.GC16869@suse.de> <44B3EB28.1050007@zytor.com>
 <20060711191548.GA17585@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Jul 2006, Olaf Hering wrote:
> > 
> > It's a proposal, and I personally think it makes sense.  If done, it is 
> > obviously very important that it doesn't change the overall operation of 
> > the system.
> 
> I think you can have that today, parted uses BLKPG to add and remoe
> things. No idea what the benefit would be, but thats not relavant for
> kinit or no kinit.

The notion that the kernel itself should do no partition parsing at all 
was advocated by Andries Brouwer. I violently disagree. Anything that the 
lack of which makes a normal system basically unusable should go into the 
kernel.

Yes, the kernel rules are heuristics, but so would inevitably any 
user-level rules be too, so I don't want to move partition detection to 
initrd or similar.

		Linus
