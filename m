Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbVIIKY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbVIIKY6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 06:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbVIIKY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 06:24:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:84 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030221AbVIIKY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 06:24:58 -0400
Date: Fri, 9 Sep 2005 12:25:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       ballen@gravity.phys.uwm.edu
Subject: Re: [PATCH] permit READ DEFECT DATA in block/scsi_ioctl
Message-ID: <20050909102501.GA25860@suse.de>
References: <43215EE4.6050003@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43215EE4.6050003@torque.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09 2005, Douglas Gilbert wrote:
> The soon to be released smartmontools 5.34 uses the
> READ DEFECT DATA command on SCSI disks. A disk that
> has defect list entries (or worse, an increasing number
> of them) is at risk.
> 
> Currently the first invocation of smartctl causes this:
>    scsi: unknown opcode 0x37
> message to appear the console and in the log.
> 
> The READ DEFECT DATA SCSI command does not change
> the state of a disk. Its opcode (0x37) is valid for
> SBC devices (e.g. disks) and SMC-2 devices (media
> changers) where it is called INITIALIZE STATUS ELEMENT
> WITH RANGE and again doesn't change the external state
> of the device.
> 
> The patch is against lk 2.6.13 .
> 
> Changelog:
>   - mark SCSI opcode 0x37 (READ DEFECT DATA) as
>     safe_for_read
> 
> Signed-off-by: Douglas Gilbert <dougg@torque.net>

Fine with me.

Acked-by: Jens Axboe <axboe@suse.de>

-- 
Jens Axboe

