Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261753AbSJMX0c>; Sun, 13 Oct 2002 19:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261755AbSJMX0c>; Sun, 13 Oct 2002 19:26:32 -0400
Received: from wv-morgantown1-235.mgtnwv.adelphia.net ([24.50.80.235]:31228
	"EHLO silvercoin") by vger.kernel.org with ESMTP id <S261753AbSJMX0c>;
	Sun, 13 Oct 2002 19:26:32 -0400
Subject: Re: harddisk corruption with 2.5.41bk and tcq enabled
From: Scott Henson <shenson2@silvercoin.dyndns.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1034422647.3da8097797dd3@smartmail.portrix.net>
References: <200210121050.01471.jan@jandittmer.de>
	<20021012091653.GD26719@suse.de> 
	<1034422647.3da8097797dd3@smartmail.portrix.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 13 Oct 2002 19:30:22 -0400
Message-Id: <1034551822.10428.7.camel@GreyGhost>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-12 at 07:37, Jan Dittmer wrote:
> > > attempt to access beyond end of device
> > > ide0(3,2): rw=0, want=1076371720, limit=19535040
> >
> At least not ide related. Just ext3 moaning.
> I'm just reinstalling debian, e2fsck just killed most of my filesystem :-(
> (including old dmesg/config).
> I'll give 2.4.42 a try on a fresh install with ext_2_. But I think there
> were no changes with respect to ext3 lately?!
> 

I had similar problems with 2.4.20-pre5-ac6 where my /home partition was
totally killed.  Though I used 2.4.19 to dd it off and ran fsck on
copies till I got it back and remounted it as a ext2 partition.  It had
some really bad corruption in the journal, but as far as I could tell
there was no other corruption.  I originally thought it was bad hard
disk, but I reinstalled to the same drive and no more errors with
2.4.20-pre8-ac3.  I also got all kinds off errors about trying to read
past the end of the device and partition magic said something about the
partition table being corrupt and not being able to determine the
partition type. Though cfdisk didnt say a thing about any of this.  Just
a wierd situation that had me confused for several days.  
-Scott Henson

