Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267681AbUHUTO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267681AbUHUTO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 15:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267674AbUHUTO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 15:14:57 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:28042 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267669AbUHUTOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 15:14:55 -0400
Date: Sat, 21 Aug 2004 12:14:17 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: James.Bottomley@SteelEye.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.8.1-mm3
Message-ID: <20040821191417.GA3402@beaverton.ibm.com>
References: <200408211838.i7LIcUdl025108@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408211838.i7LIcUdl025108@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2004 at 08:38:30PM +0200, Mikael Pettersson wrote:

> I checked now, and I can also trigger the message on ide-scsi + sr
> (CD writer), but not on ide-scsi + st (ATAPI tape drive) or on
> a SCSI disk on a SYM53C8XX controller.
> 
> So it seems both usb storage and ide-scsi (or the cdrom module)
> generate these ioctls.

Looks like it will be hit for any scsi removable media, the removable
media check in sd.c sd_media_changed() uses SCSI_IOCTL_TEST_UNIT_READY.

-- Patrick Mansfield
