Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279242AbRKFQiR>; Tue, 6 Nov 2001 11:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279778AbRKFQiH>; Tue, 6 Nov 2001 11:38:07 -0500
Received: from sweetums.bluetronic.net ([66.57.88.6]:41109 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S279242AbRKFQiC>; Tue, 6 Nov 2001 11:38:02 -0500
Date: Tue, 6 Nov 2001 11:37:51 -0500 (EST)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Mylex/Compaq RAID controller placement in config
In-Reply-To: <Pine.LNX.4.30.0111061612570.23908-100000@mustard.heime.net>
Message-ID: <Pine.GSO.4.33.0111061132290.17287-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001, Roy Sigurd Karlsbakk wrote:
>I know it might seem silly, but as to make things clearer for most
>users/admins, wouldn't it be better to just call them SCSI controllers, as
>they all indeed connect SCSI drives to the host?

No!  That would actually increase the confusion.  You can connect almost any
SCSI device to the Mylex RAID controller, but you won't be able to use
anything that isn't a drive configured through the controller. (There's a
DOS ASPI driver to let you see a CDROM on the bus, but that's only there
for installation support.)

If you list the RAID controller as a SCSI device, people *will* think they
can plug any SCSI device they have onto it and be able to use it.  Well,
they cannot (and never will.)  Additionally, nothing the driver provides
lives under /dev/{sd,st,sg}* and you have ZERO SCSI layer access through
the driver.

--Ricky


