Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVCIGKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVCIGKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 01:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVCIGKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 01:10:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:49627 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261708AbVCIGIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 01:08:50 -0500
Date: Tue, 8 Mar 2005 22:04:50 -0800
From: Greg KH <greg@kroah.com>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050309060450.GA17560@kroah.com>
References: <42225A64.6070904@us.ltcfwd.linux.ibm.com> <20050228065534.GC23595@kroah.com> <4228CE5C.9010207@us.ltcfwd.linux.ibm.com> <20050305064445.GA8447@kroah.com> <422CDA58.5000506@us.ltcfwd.linux.ibm.com> <20050308064211.GE17022@kroah.com> <422DF217.8070401@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422DF217.8070401@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 01:42:31PM -0500, Wen Xiong wrote:
> The following email I got from Scott Kilau in digi:
> Scott Kilau wrote:
> 
>        The DPA program is very old, and is shared among other drivers 
> and OS's,
>        so changing the code to read the sysfs instead of doing ioctls 
> is not possible.

Hm, so we are supposed to support, for forever, custom ioctls just
because another OS, that we care nothing about, supports it?  Hm, I just
can't think this is a acceptable thing, sorry.  Especially due to the
nasty 64/32 bit issues...

>        However, any *new* tools I write, will use sysfs, which is why 
> we need to have both the ioctl calls and sysfs files.

Please, no new ioctls, end of story.

>        The digi.h file has extra structures and ioctls that may not be 
> used in the driver, as that header
>        is shared among other drivers and OS's.

Please remove them as they are not needed in this OS, right?  As you
already had to change the naming, structure definitions, and format, you
aren't sharing the file.

thanks,

greg k-h
