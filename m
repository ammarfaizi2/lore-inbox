Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267662AbUHEM0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267662AbUHEM0J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 08:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267663AbUHEM0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 08:26:09 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:17646 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267662AbUHEM0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 08:26:07 -0400
Date: Thu, 5 Aug 2004 14:25:29 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408051225.i75CPT4U004434@burner.fokus.fraunhofer.de>
To: axboe@suse.de, kernel@wildsau.enemy.org
Cc: linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Jens Axboe <axboe@suse.de>

>ATA method is misnamed, it's really SG_IO that is used. And you want to
>use that regardless of the device type, SCSI or ATAPI. There's no such
>thing as an ATA burner, and there's no need to differentiate between
>SCSI or ATAPI CD-ROM's when burning - SG_IO is the method to use. So
>forget browsing /proc/ide and other hacks.

I am sorry but as Linux already has 6 different interfaces for sending 
Generic SCSI commands and thus, we are running out of names.

Let me give you an advise: consolidate Linux so that is does only need
/dev/sg and fix the bugs in ide-scsi instead of constantly inventing new
unneeded interfaces.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
