Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273372AbRIRLGb>; Tue, 18 Sep 2001 07:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273382AbRIRLGW>; Tue, 18 Sep 2001 07:06:22 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:531 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S273372AbRIRLGG>; Tue, 18 Sep 2001 07:06:06 -0400
Message-ID: <3BA72A8F.2C9CF506@idb.hist.no>
Date: Tue, 18 Sep 2001 13:05:51 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.10-pre10 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010918115713.C2723@athlon.random> <Pine.GSO.4.21.0109180558150.25323-100000@weyl.math.psu.edu> <20010918121716.D2723@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> very clear now, thanks. I though the fs you were talking about was
> mounted on the blkdev, while it is instead the one where the blkdev
> inode cames from. Usually people keeps bldkev in /dev and nobody
> unmounts /dev that's why I didn't noticed and thought about it, sorry.
> 
Don't assume "nobody does..."  There is always someone that do.

This particular one will easily come up for anybody who
develop boot floppies:

1.  Mount the boot floppy at /mnt
2.  Test the device files in /mnt/dev, _perhaps by using them
    in every way imaginable_
3.  Umount the boot floppy. - There goes /mnt/dev and a bunch
    of block devices.  

Umounting some dev/ is common enough.

Helge Hafting
