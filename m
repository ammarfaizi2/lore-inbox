Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135311AbRAQTWu>; Wed, 17 Jan 2001 14:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135217AbRAQTWk>; Wed, 17 Jan 2001 14:22:40 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:55057 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S131406AbRAQTWc>;
	Wed, 17 Jan 2001 14:22:32 -0500
Date: Wed, 17 Jan 2001 20:22:22 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010117202222.B4979@almesberger.net>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95191@ATL_MS1> <Pine.LNX.4.21.0101161154580.17397-100000@sol.compendium-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0101161154580.17397-100000@sol.compendium-tech.com>; from kernel@blackhole.compendium-tech.com on Tue, Jan 16, 2001 at 12:01:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Ccs trimmed ]

Dr. Kelsey Hudson wrote:
> *single* scsi adapter in their systems? do we need to bloat the kernel
> with automatic things like this? no... i think it is handled fine the way

"no", because you don't have to do it in the kernel. You can mount by
uuid or label. For the root FS, you do this from an initrd. Problem
solved.

The only cases when you really need to know the name of a disk is when
 - doing disk-level management, e.g. partitioning or creating file
   systems (*)
 - adding a swap partition (sigh)
 - telling your boot loader where to put its boot sector

(* in principle, you could even avoid this, if you have some means of
   identifying a disk (e.g. via the uuid of a file system). However,
   I would consider such a solution to be overly fragile.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
