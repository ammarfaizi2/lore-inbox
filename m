Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTLQSHl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 13:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTLQSHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 13:07:41 -0500
Received: from mail.kroah.org ([65.200.24.183]:16260 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264490AbTLQSHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 13:07:40 -0500
Date: Wed, 17 Dec 2003 10:07:29 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@gentoo.org>, dsteklof@us.ibm.com,
       patmans@us.ibm.com
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: scsi_id segfault with udev-009
Message-ID: <20031217180729.GB6487@kroah.com>
References: <1071682198.5067.17.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071682198.5067.17.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 07:29:58PM +0200, Martin Schlemmer wrote:
> Hi
> 
> Getting this with scsi_id and udev-009:
> 
> --
> Starting program:
> /space/var/tmp/portage/udev-009/work/udev-009/extras/scsi_id/scsi_id -p
> 0x80 -s /block/sdb
>  
> Program received signal SIGSEGV, Segmentation fault.
> 0x080499c5 in sysfs_get_attr (dev=0x80d2d68, attr=0x80b559c "dev") at
> scsi_id.h:45
> 45              return
> sysfs_get_value_from_attributes(dev->directory->attributes,
> (gdb) k
> Kill the program being debugged? (y or n) y

Yeah, I bet this is due to the libsysfs change that is now in udev.  If
I get a chance, I'll look into it.  Unless Pat or Dan beats me to it...

thanks,

greg k-h
