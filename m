Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbTLZBsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 20:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbTLZBsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 20:48:19 -0500
Received: from dirac.phys.uwm.edu ([129.89.57.19]:24254 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S264446AbTLZBsN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 20:48:13 -0500
Date: Thu, 25 Dec 2003 19:47:57 -0600 (CST)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: dan carpenter <error27@email.com>
cc: Carlo <devel@integra-sc.it>, Oleg Drokin <green@linuxhacker.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: Ooops with kernel 2.4.22 and reiserfs
In-Reply-To: <200312250433.50550.error27@email.com>
Message-ID: <Pine.GSO.4.21.0312251946460.2554-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > C> hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete
> > > C> DataRequest }
> > > C> ide0: Drive 0 didn't accept speed setting. Oh, well.
> > > C> hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> > > C> hda: CHECK for good STATUS
> > >
> 
> I would check for SMARTerrors:  smartctl -a /dev/hda 
> Also you could try running badblocks on the drive.

Run some drive self-tests:
   smartctl -t long /dev/hda
and let them complete, then look again at
   smartctl -a /dev/hda

Cheers,
	Bruce

