Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266526AbUHIMJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266526AbUHIMJT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUHIMIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:08:43 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:21198 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266508AbUHIMG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 08:06:28 -0400
Date: Mon, 9 Aug 2004 14:05:48 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408091205.i79C5mW3009645@burner.fokus.fraunhofer.de>
To: paul@clubi.ie, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org,
       mj@ucw.cz
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Paul Jakma <paul@clubi.ie>

>That the /dev/dsk names typically encode some *logical* topology 
>information into the names is beside the point, it's just the Solaris 
>convention, the real point is that they abstract the device location, 
>so that the user is not required to know that their disk is really 
>at, eg:

> 	/devices/pci@0,0/pci-ide@7,1/ide@1/sd@0,0:d,raw

>Which is where the /dev/ node would symlink to. The /dev/ name has 
>nothing to do with physical topology (though might be vaguely 
>similar). Also note that the logical /dev/ symlink name is encoded 
>*differently* for IDE versus SCSI. Trying to plaster SCSI notations 
>into IDE topology is just not useful. Indeed, some devices are not 
>dependent on topology at all, they depend on some other topology 
>independent identifier, eg FC UUID.

Don't comment things you don't ever try.....

Of course, ATAPI devices on Solaris are handled by the same
target drivers as e.g. those on 50 pin cables.

The ATA driver is implemented the way one would expect it by acting as a SCSI 
HBA.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
