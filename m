Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291518AbSBMKeN>; Wed, 13 Feb 2002 05:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291522AbSBMKeD>; Wed, 13 Feb 2002 05:34:03 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:43022 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S291518AbSBMKdq>; Wed, 13 Feb 2002 05:33:46 -0500
Date: Wed, 13 Feb 2002 11:33:43 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Quick question on Software RAID support.
In-Reply-To: <E16aoUH-0003mY-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0202131109270.21300-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Alan Cox wrote:

> > 1) Does the Software RAID-5 support automatic detection
> >      of a drive failure? How?
> 
> It sees the commands failing on the underlying controller. Set up a software
	 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Is it supposed to detect a failed disk and *stop* using it?

I had a raid1 IDE system, and it was continuosly raising hard errors on
hdc (the disk was dead, non just some bad blocks): the net result was that
it was unusable - too slow, too busy on IDE errors (a lot of them - even
syslog wasn't happy).

Ok, all it took me was to replace the disk, partition it and raidhotadd
devices. Yet it needed manual intervention. I wish it performed an
raidhotremove automagically so to run with decent performance...
even if in "degraded mode". It was RH 2.2.19, so things may have changed
meanwhile.

BTW, given a 2 disks IDE raid1 setup (hda / hdc), does it pay to put a
third disk in (say hdb) and configure it as "spare disk"? I've got 
concerns about the slave not actually beeing able to operate if the
master (hda) fails badly.

TIA,
.TM.

