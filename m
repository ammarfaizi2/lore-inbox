Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265908AbRGOEDE>; Sun, 15 Jul 2001 00:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265902AbRGOECy>; Sun, 15 Jul 2001 00:02:54 -0400
Received: from weta.f00f.org ([203.167.249.89]:50563 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S265844AbRGOECo>;
	Sun, 15 Jul 2001 00:02:44 -0400
Date: Sun, 15 Jul 2001 16:02:47 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010715160247.I7624@weta.f00f.org>
In-Reply-To: <E15LL3Y-0000yJ-00@the-village.bc.nu> <p05100307b7762dc5d8ad@[207.213.214.37]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p05100307b7762dc5d8ad@[207.213.214.37]>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2001 at 10:33:44AM -0700, Jonathan Lundell wrote:

    What's worse, though the spec is not explicit on this point, it
    appears that the write cache is lost on a SCSI reset, which is
    typically used by drivers for last-resort error recovery. And of
    course a SCSI bus reset affects all the drives on the bus, not
    just the offending one.

Doesn't SCSI have a notion of write barriers?

Even if this is required, the above still works because for anything
requiring a barrier, you wait of a positive SYNCHRONIZE CACHE



  --cw


