Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267546AbRGMVHW>; Fri, 13 Jul 2001 17:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267544AbRGMVHK>; Fri, 13 Jul 2001 17:07:10 -0400
Received: from weta.f00f.org ([203.167.249.89]:13187 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267539AbRGMVHD>;
	Fri, 13 Jul 2001 17:07:03 -0400
Date: Sat, 14 Jul 2001 09:07:03 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010714090703.B5737@weta.f00f.org>
In-Reply-To: <200107132041.f6DKfqM8013404@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107132041.f6DKfqM8013404@webber.adilger.int>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2001 at 02:41:52PM -0600, Andreas Dilger wrote:

    Yes, RAID should have a journal or other ordering enforcement, but
    it really isn't any worse in this regard than a single disk.  Even
    on a single disk you don't have any guarantees of data ordering,
    so if you change the file and the power is lost, some of the
    sectors will make it to disk and some will not => fsck, with
    possible data corrpution or loss.

How so? On a single disk you can either disable write-caching or for
SCSI disks you can use barriers of sorts.

At which time, you can either assume a sector is written or not.


   --cw
