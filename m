Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUHGK3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUHGK3z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 06:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUHGK3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 06:29:55 -0400
Received: from ppp3-adsl-39.the.forthnet.gr ([193.92.234.39]:7975 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S261234AbUHGK3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 06:29:54 -0400
From: V13 <v13@priest.com>
To: Martin Mares <mj@ucw.cz>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Sat, 7 Aug 2004 13:31:34 +0300
User-Agent: KMail/1.6.82
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, axboe@suse.de,
       James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
References: <200408061330.i76DU2Tm005937@burner.fokus.fraunhofer.de> <20040806231529.GA9997@ucw.cz>
In-Reply-To: <20040806231529.GA9997@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408071331.38793.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 August 2004 02:15, Martin Mares wrote:
> Hello!
>
> > Let me lead you to the right place to look for:
> >
> > 	The CAM interface (which is from the SCSI standards group)
> > 	usually is implemeted in a way that applications open /dev/cam and
> > 	later supply bus, target and lun in order to get connected
> > 	to any device on the system that talks SCSI.
> >
> > Let me repeat: If you believe that this is a bad idea, give very good
> > reasons.
>
> There is one: hotplug. The physical topology of buses where all the
> SCSI-like devices (being it ATAPI devices, iSCSI, USB disks or other such
> beasts) are connected is too complex, so every attempt to map them to the
> (bus, target, lun) triplets in any sane way is destined to fail.

Just to add on this, how is someone supposed to distinguish between two 
identical USB recorders using the scanbus/X:Y:Z method? I suppose he'll have 
to try writting to both drives each time he replugs them instead of 
having /dev/cdr-red /dev/cdr-blue or something similar using hotplug/udev.

<<V13>>
