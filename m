Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265848AbUACBJS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 20:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265856AbUACBJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 20:09:18 -0500
Received: from mx15.sac.fedex.com ([199.81.197.54]:24586 "EHLO
	mx15.sac.fedex.com") by vger.kernel.org with ESMTP id S265848AbUACBJO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 20:09:14 -0500
Date: Sat, 3 Jan 2004 08:55:40 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Jeff Chua <jchua@fedex.com>
cc: Jens Axboe <axboe@suse.de>, Michael Hunold <hunold@convergence.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: GetASF failed on DVD authentication
In-Reply-To: <Pine.LNX.4.58.0401030830360.407@boston.corp.fedex.com>
Message-ID: <Pine.LNX.4.58.0401030849040.806@boston.corp.fedex.com>
References: <Pine.LNX.4.58.0401021616580.4954@boston.corp.fedex.com>
 <20040102103949.GL5523@suse.de> <Pine.LNX.4.58.0401022219290.10338@silk.corp.fedex.com>
 <3FF5986C.8060806@convergence.de> <20040102161813.GA21852@suse.de>
 <20040102163024.GS5523@suse.de> <Pine.LNX.4.58.0401030830360.407@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/03/2004
 09:09:09 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/03/2004
 09:09:12 AM,
	Serialize complete at 01/03/2004 09:09:12 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jan 2004, Jeff Chua wrote:

> The log showed "Illegal Request: invalid command operation code" when I
> issued "tstdvd".

> Jan  3 08:17:48 boston kernel: usb-storage: -- code: 0x70, key: 0x5, ASC: 0x20, ASCQ: 0x0
> Jan  3 08:17:48 boston kernel: usb-storage: Illegal Request: invalid command operation code


Ok, I applied Jens's patch, rmmod sg, rmmod cdrom, and retest "tstdvd".

This time, debug still shows the same "Illegal Request", BUT the drive
successfully authenticated.

I tried the following command, but still couldn't get scsi log ...

echo "scsi log error,scan,mlqueue,mlcomplete,llqueue,llcomplete,hlqueue,hlcomplete 9"
>/proc/scsi/scsi


Thanks,
Jeff


