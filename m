Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbTHaIff (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 04:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTHaIff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 04:35:35 -0400
Received: from mx13.sac.fedex.com ([199.81.197.53]:13834 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S262024AbTHaIfd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 04:35:33 -0400
Date: Sun, 31 Aug 2003 16:33:57 +0800 (SGT)
From: Jeff Chua <jeff89@silk.corp.fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: Gerardo Exequiel Pozzi <djgeray2k@yahoo.com.ar>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] hda:end_request: I/O error, dev 03:00 (hda), sector 0
In-Reply-To: <20030831045220.3ace5a34.djgeray2k@yahoo.com.ar>
Message-ID: <Pine.LNX.4.42.0308311627370.22892-100000@silk.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/31/2003
 04:35:28 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/31/2003
 04:35:31 PM,
	Serialize complete at 08/31/2003 04:35:31 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 31 Aug 2003, Gerardo Exequiel Pozzi wrote:
> >Partition check:
> > hda:end_request: I/O error, dev 03:00 (hda), sector 0
> > unable to read partition table
>
> I suppose that your disk will be in good state, ok,

works perfectly. The same problems show up on all systems. All kernel
version 2.4.x.


> A time ago I had the same error (with hdc), and was that had forgotten
> to clear the hdc=ide-scsi from of the line append in lilo.

I check that. Don't have this defined.


I guess it could be my .config

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y


I wanted ID to be loaded as a module, but couldn't set CONFIG_IDE=m as
that would prevent "hdparm -d1 /dev/hda" from working.

Thanks,
Jeff


