Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262293AbSJDQMW>; Fri, 4 Oct 2002 12:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262294AbSJDQMW>; Fri, 4 Oct 2002 12:12:22 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:9365 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262293AbSJDQMU>; Fri, 4 Oct 2002 12:12:20 -0400
Date: Fri, 4 Oct 2002 10:17:34 -0600
Message-Id: <200210041617.g94GHY008334@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Greg KH <greg@kroah.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [BK PATCH] minor devfs cleanup for 2.5.40
In-Reply-To: <20021003213908.GB1388@kroah.com>
References: <20021003213908.GB1388@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:
> Here's a changeset from Christoph Hellwig that removes some unneeded
> code from the kernel core.  This was leftover from before devfs became
> part of the main kernel tree, and was trying to do some naming fixups in
> kernelspace.  If anyone still has machines using these names, their
> startup scripts should be modified to use the "standard" devfs names.
> 
> Please pull from:  http://linuxusb.bkbits.net/devfs-2.5

NO! Dammit, you'll break everyone who is using these compact names to
mount the root FS. Look more closely at the code you're trying to
remove, and you'll see it's *not* used to avoid work in startup
scripts. It's only used to create the devfs entry for the root FS.

This change is gratuitous. The code is __init code anyway, so doesn't
contribute to bloat. And forcing people to migrate to the longer names
isn't reasonable, as it chews up precious space on the kernel command
line. I've had times where I ran out of space when I had too many
options.

Linus, please don't apply.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
