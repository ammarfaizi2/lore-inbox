Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319309AbSH2TVK>; Thu, 29 Aug 2002 15:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319312AbSH2TVK>; Thu, 29 Aug 2002 15:21:10 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:56572
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319309AbSH2TVI>; Thu, 29 Aug 2002 15:21:08 -0400
Subject: Re: 2.4.20-pre4-ac1 trashed my system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mike Isely <isely@pobox.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208291412120.13200-100000@grace.speakeasy.net>
References: <Pine.LNX.4.44.0208291412120.13200-100000@grace.speakeasy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 29 Aug 2002 20:28:03 +0100
Message-Id: <1030649283.7290.168.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-29 at 20:15, Mike Isely wrote:
> I've done some more looking through the lkml archives and I found
> discussions from March / April about LBA48 problems and the Promise
> controller.  Clearly from that, exactly how well LBA48 works seems to

That was when the original work got done if I remember rightly

> depend a lot on whether or not PIO vs DMA vs UltraDMA is being used.
> Also it looks like if CONFIG_IDE_TASKFILE_IO is on then things may yet
> be different.  To those points, I can add these details for my
> situation: I believe the driver was in UltraDMA mode at the time and I
> had CONFIG_IDE_TASKFILE_IO turned on.

PIO LBA48 seems to work on all promise
Early promise needs a helping hand with DMA LBA48, one promise doesnt
seem to do DMA LBA48 on secondary at all, and newer stuff gets it right.
 
> all.  I understand the doubt.  The simple fact however is that I still
> have a trashed system, and it happened only after updating the kernel.
> I know that's not a lot to go on, and again I apologize for lack of
> detail.  I originally wasn't going to post to lkml about this; I have
> been a quiet Linux user for 8+ years and really felt that a problem of
> this severity would probably already have been noticed.  I really

You've actually provided prety much all the key information. The things
that matter are:

	The file system was known good, passed fsck before you ran the
	recent kernel

	The file system wasnt good after this

	The problem is replicatable

And what controller/drives which you've provided.


> If I'm the only one that has hit this - another reason for doubt -
> then I guess have no choice but to dig deeper.  I can't really leave
> the broken system like this to play with.  However I do have a smaller
> spare hard drive and I'll make that the new system disk, leaving the
> 160GB Maxtor attached to the Promise controller (with nothing valuable
> on it).  I should be able to replicate the corruption and provide more
> information here, hopefully while still having a usable system.

If you can replicate it and find out where the problem begins that would
be wonderful in itself.

