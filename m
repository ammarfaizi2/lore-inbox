Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261756AbTCZQYV>; Wed, 26 Mar 2003 11:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261768AbTCZQYV>; Wed, 26 Mar 2003 11:24:21 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:60068 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261756AbTCZQYU>; Wed, 26 Mar 2003 11:24:20 -0500
Date: Wed, 26 Mar 2003 17:34:46 +0000
From: norbert_wolff@t-online.de (Norbert Wolff)
To: linux-kernel@vger.kernel.org
Subject: Re: Can not open '/dev/sg0' - attach failed.
Message-Id: <20030326173446.3980a177.norbert_wolff@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Mar 2003 21:00:22 +0530
"Subramanian, M (MED)" <M.Subramanian@geind.ge.com> wrote:

> cdrecord error
> ==============
> 
> scsibus: 1 target: 0 lun: 0
> Cannot open '/dev/sg0'
> 
> lsmod
> 
> Module                  Size  Used by
> sg                     26688   0 
> ide-scsi                8352   0 
> ide-cd                 26848   0 
> cdrom                  27232   0  [ide-cd]

High !

Your cdrom-Module seems to use the ide-cd-driver, so cdrecord's lib which needs 
SCSI-emulation for IDE-Drives (I think your CD-RW is an IDE-one ?) cannot work.

You need to load the sr-Driver (Driver for SCSI-CDRoms) instead of the
ide-cd-driver.

Regards,

	Norbert

