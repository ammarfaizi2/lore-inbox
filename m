Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVK3I6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVK3I6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 03:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVK3I6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 03:58:35 -0500
Received: from CPE-24-31-244-49.kc.res.rr.com ([24.31.244.49]:60630 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S1751149AbVK3I6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 03:58:35 -0500
From: Luke-Jr <luke-jr@utopios.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd doesn't replace ide-scsi?
Date: Wed, 30 Nov 2005 09:03:13 +0000
User-Agent: KMail/1.9
References: <200511281218.17141.luke-jr@utopios.org> <58cb370e0511290658m682ae978hea2100f57252a928@mail.gmail.com> <20051129152300.GX15804@suse.de>
In-Reply-To: <20051129152300.GX15804@suse.de>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511300903.15184.luke-jr@utopios.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 November 2005 15:23, Jens Axboe wrote:
> On Tue, Nov 29 2005, Bartlomiej Zolnierkiewicz wrote:
> > > Unfortunately using ide-cd still doesn't have the code set to allow all
> > > burning features to work if you are not root. Even if you have
> > > read+write there's one command you need to do multi-session which is
> > > only allowed to root. Works fine for single sessions, I guess that's
> > > all someone uses.
> >
> > Interesting because both drivers ide-cd and sr+ide-scsi use exactly
> > the same code (block/scsi_ioctl.c) to verify which commands don't
> > need root privileges.  Care to give details?
>
> Not if he is using /dev/sgX with ide-scsi, only SG_IO through /dev/srX
> will go through the block/scsi_ioctl.c path.

Actually, growisofs refuses to work with anything but a block device-- so it's 
using /dev/sr1. So apparently something else is up, since ide-cd errors, yet 
ide-scsi does not.

Apparently, ide-scsi isn't working either though, just a different problem: 
the burning *appears* to work (I get status info, and the drive seems to do 
something), but the disc ends up unburned and empty. Has anyone successfully 
burned a dual layer disc? I'm using a BenQ DW1620 drive.
-- 
Luke-Jr
Developer, Utopios
http://utopios.org/
