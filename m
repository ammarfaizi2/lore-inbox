Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132279AbRC1TwM>; Wed, 28 Mar 2001 14:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132147AbRC1TwC>; Wed, 28 Mar 2001 14:52:02 -0500
Received: from [195.180.174.223] ([195.180.174.223]:9344 "EHLO idun.neukum.org") by vger.kernel.org with ESMTP id <S132163AbRC1Tvv>; Wed, 28 Mar 2001 14:51:51 -0500
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, Oliver.Neukum@lrz.uni-muenchen.de, jesse@cats-chateau.net
Subject: Re: Larger dev_t
Date: Wed, 28 Mar 2001 21:50:20 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
References: <200103281905.NAA41794@tomcat.admin.navo.hpc.mil>
In-Reply-To: <200103281905.NAA41794@tomcat.admin.navo.hpc.mil>
MIME-Version: 1.0
Message-Id: <01032821502009.01508@idun>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > And what would you do if the names collide ?
>
> refuse to mount - give the admin time to fix them in single user mode

That means that it could only be used for optional filesystems otherwise
booting unattended is put into question.
A user set for a practical joke could prevent booting by leaving a medium in 
the drive. You could add options for not considering removable media, etc, 
but you get to a stage where you design workarounds. That'd be bad for core 
filesystems. Thus the need for a second improved system remains.

Aside from that adding the name to /proc/partions is a good idea but not 
universally usable.

> I'm still thinking about how the root filesystem could be mounted during
> boot where devfs and /proc are not yet mounted.

Enable the kernel command line to understand devfs names.

> locate the serial number in /proc/scsi/scsi. use devfs name that
> corresponds to this device (scsi2/target 6/lun/00 or similar) and
> create a symbolic link for it. This does assume that the serial number or
> equivalent is available to be searched for. It also assumes that the

This is the problem. I wouldn't trust it.

> Is this reasonable? Perhaps not for small systems, but when lots of dynamic
> devices are available it is needed

It is reasonable. GUIs could use a unified way to learn volume names.

	Regards
		Oliver
