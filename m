Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbREXRbp>; Thu, 24 May 2001 13:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbREXRbf>; Thu, 24 May 2001 13:31:35 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:29174 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261558AbREXRbW>; Thu, 24 May 2001 13:31:22 -0400
Message-ID: <9678C2B4D848D41187450090276D1FAE0635F05A@FMSMSX32>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'Jonathan Lundell'" <jlundell@pobox.com>, Jens Axboe <axboe@suse.de>,
        Andi Kleen <ak@suse.de>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        monkeyiq <monkeyiq@users.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: RE: Dying disk and filesystem choice.
Date: Thu, 24 May 2001 10:30:43 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>At 12:19 PM +0200 2001-05-24, Jens Axboe wrote:
>>In fact you will typically only see an I/O error if the drive _can't_
>>remap the sector anymore, because it has run out. No point in reporting
>>a condition that was recovered.
>>
>>I'd still say, that if you get bad block errors reported from your disk
>>it's long overdue for replacement.

On Thursday, May 24, 2001 11:46 AM, Jonathan Lundell wrote:
>This can't be right. It implies that the drive is returning bogus 
>data with no error indication. Remapping a bad sector is not the same 
>as recovering it.

The automatic reallocation of bad spots on a drive is safe unless paired
with the write cache enabled bit in the disk mode pages (configuration).
WCE, in some cases, can cause the write/read to both take place from cache
with good status, and if the bad spot is reallocated later, when the cache
is flushed, the reporting gets very confusing.

In general:
It is a common misconception that if a disk begins to show some bad spots,
that it should be replaced.  In fact, a disk can have a reliable, useful
life for years after bad spots begin to show up.  The number of bad spots in
the Grown Defect List over a specified time as a % of capacity can be an
predictor of impending failure, however.

Andy Cress


