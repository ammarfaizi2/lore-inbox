Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268881AbUIMTOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268881AbUIMTOQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 15:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268878AbUIMTOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 15:14:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26273 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268870AbUIMTN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 15:13:58 -0400
Date: Mon, 13 Sep 2004 21:12:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Joshua Schmidlkofer <kernel@pacrimopen.com>
Cc: Con Kolivas <kernel@kolivas.org>, jch@imr-net.com,
       ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Cliff Wells <clifford.wells@comcast.net>
Subject: Re: [ck] Re: 2.6.8.1-ck7, Two Badnessess, one dump.
Message-ID: <20040913191237.GF18883@suse.de>
References: <41412765.4010005@kolivas.org> <4144F691.6040405@pacrimopen.com> <41451957.7000101@kolivas.org> <4145BAE9.1040800@pacrimopen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4145BAE9.1040800@pacrimopen.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13 2004, Joshua Schmidlkofer wrote:
> Con,
> 
> 
>    I did not mention before, I thought it was a fluke on my system. Now 
> its affecting two systems since applying ck7.
> 
> 
> <snip>
> hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> ide: failed opcode was: unknown
> hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete 
> DataRequest }ide: failed opcode was 100
> hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> ide: failed opcode was: unknown
> hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete 
> DataRequest }ide: failed opcode was 100
> hda: CHECK for good STATUS
> <snip>
> 
> That is happening while applying the dma settings to the hard drive.
> 
> In both cases, the drive is a Western Digital 40GB hard drive.  That is 
> the only solid commoniality.  One is a P4 2.8, the other a P4 2.4.   
> Intel Chipset + Intel IDE in one, Intel Chipset + HighPoint chipset in 
> the other. 
> 
> However, the code is exactly the same.

Is your drive idle while applying dma settings? Current 2.6 kernels
aren't even close to being safe to modify drive settings, since it makes
no effective attempts to serialize with ongoing commands. I have a
half-assed patch to fix that.

-- 
Jens Axboe

