Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTKFTpx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 14:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbTKFTpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 14:45:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:8637 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263806AbTKFTpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 14:45:51 -0500
Date: Thu, 6 Nov 2003 11:45:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: bill davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <boe6in$f4q$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0311061143300.1842-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Nov 2003, bill davidsen wrote:
> 
> I'm not sure what you mean by faster, burning runs at device limited
> speed in CPU time in the  less than 1% range if you remember to enable
> DMA. The last time I looked DMA didn't work in either kernel if write
> size was not a multiple of 1k, (or 2k?) has that changed?

DMA works fine 

	IF YOU DON'T USE IDE-SCSI

Don't use it. Please. There's no point. 

It's much more readable to do

	cdrecord dev=/dev/hdc

than it is to do some stupid "scan SCSI devices" + "dev=0,1,0" or similar 
totally incomprehensible crap that doesn't even work right.

> I'm not sure what you meant by faster, so don't think I'm disagreeing
> with you.

Faster as in "it uses DMA for everything, so you can actually burn at full 
speed without having to worry about it or sucking up CPU".

		Linus

