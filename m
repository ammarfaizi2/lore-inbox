Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266710AbRGORLC>; Sun, 15 Jul 2001 13:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbRGORKw>; Sun, 15 Jul 2001 13:10:52 -0400
Received: from weta.f00f.org ([203.167.249.89]:13700 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266710AbRGORKl>;
	Sun, 15 Jul 2001 13:10:41 -0400
Date: Mon, 16 Jul 2001 05:10:46 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010716051046.A10956@weta.f00f.org>
In-Reply-To: <E15LL3Y-0000yJ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15LL3Y-0000yJ-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2001 at 09:45:44AM +0100, Alan Cox wrote:

    As far as I can tell none of them at least in the IDE world

Can you test with the code I posted a hour or so ago please?

I ask this because I tested writes to:

  -- buffered devices

  -- ide with caching on

  -- ide with caching off

  -- scsi (caching on?)

To a buffered device, I get something silly like 63000
writes/second. No big surprises there (other than Linux is bloody lean
these days).

To a SCSI device (10K RPM SCSI-3 160 drive), I get something like 167
writes/second, which seems moderately sane if caching is disabled.

To a cheap IDE drive (5400 RPM?) with caching off, I get about 87
writes/second.

To the same drive, with caching on, I get almost 4000 writes/second.

This seems to imply, at least for my test IDE drive, you can turn
caching off --- and its about half as fast as my SCSI drives which
rotate at about twice the speed (sanity check).

IDE drive:  IBM-DTTA-351010, ATA DISK drive
SCSI drive: SEAGATE ST318404LC




   --cw


