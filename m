Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130431AbRARIiv>; Thu, 18 Jan 2001 03:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130792AbRARIib>; Thu, 18 Jan 2001 03:38:31 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:23062 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S130431AbRARIi1>; Thu, 18 Jan 2001 03:38:27 -0500
Date: Thu, 18 Jan 2001 10:38:09 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File System Corruption with 2.2.18
Message-ID: <20010118103809.P1265@niksula.cs.hut.fi>
In-Reply-To: <Pine.LNX.4.30.0101180035080.28099-100000@pine.parrswood.manchester.sch.uk> <Pine.LNX.4.10.10101171645110.19441-200000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101171645110.19441-200000@master.linux-ide.org>; from andre@linux-ide.org on Wed, Jan 17, 2001 at 05:14:02PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 05:14:02PM -0800, you [Andre Hedrick] claimed:
> On Thu, 18 Jan 2001, Tim Fletcher wrote:
> 
> > > Well that is useless test them because you can not test things completely.
> > 
> > I ment that if the partiton has no persient data on it then the test can
> > be run (the test wipes all data on the partition out during the test,
> > right?) with no loss of data on the machine. The partition is still on the
> > same disk so the test data is valid?
> > 
> > I am thinking that the test is somewhat like badblocks -w or have I got
> > the wrong end of the stick?
> 
> Sorry there is no stick to get the end of....
> This is a pure diagnostic tool the determine OS/CHIPSET/DEVICE failures.
> You generate a pattern buffer and write it to the disk and step the buffer
> 1 byte per sector and go head to tail.  Then you read it back head to tail
> and compare what should be there with what is there.  Failures == FS
> corruption is likely under highest loads, period.  Then you attempt 
> to extract any patterns or periodic events to determine if it is driver or
> device or other portions of the OS.
> 
> I am tired of people pointing the finger at me claim my work is the cause
> of FS corruption.
> 
> This is a pattern walk and it will give some performance issue.
> It does not care about the OS, it is doing the direct access that some
> would call bit-bangging in the old days.

But it works on all ATA disks? Does it work for SCSI as well?

I think it would be cool if you'd make it available (on linux-ide.org?),
so that people install servers (and anybody who _cares_) could test their
hardware/driver combination before starting using the box.

Now we have memtest86, cpuburn (what more). It would be nice to have a
good (if not complete) test set to run on each new linux box. It's not
nice to use the box for a month and then go "f..., this box has faulty
memory!" or ..."faulty disk!". Yes, that's what's happened to all of us.

It's much nicer to get a warranty replacement, when you don't have any
data on the disk.


-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
