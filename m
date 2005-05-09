Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVEIRGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVEIRGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 13:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVEIRGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 13:06:15 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:50289 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261165AbVEIRGI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 13:06:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E8L4lKjiz3d9ldpIkK7R/4E/l3jCB3ALDV2ynNEcYQyatuUhVFMhRHkgppWez9D0W6ytOrjiPg7WrLouIDdMAbzdsFqg72oEWB3VlHmfmSYxW3R+ScoML9mz0ns6FXXItE/7D41v33OD+BP4iFj+zQLpmFncjF/jtVgoryEfeK4=
Message-ID: <5eb4b065050509100638bd7970@mail.gmail.com>
Date: Tue, 10 May 2005 01:06:08 +0800
From: KC <kcc1967@gmail.com>
Reply-To: KC <kcc1967@gmail.com>
To: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: proc_mknod() replacement
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050509154147.GC5799@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5eb4b06505050904172655477c@mail.gmail.com>
	 <20050509154147.GC5799@harddisk-recovery.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for reply.

On 5/9/05, Erik Mouw <erik@harddisk-recovery.com> wrote:
> On Mon, May 09, 2005 at 07:17:44PM +0800, KC wrote:
> > I found that proc_mknod() had been removed from kernel 2.6.x.
> > Any replacement ?
> >
> > Or how can I create file, device node or dir from device driver ?
> 
> You don't do that from a device driver in the first place. Have a look
> at udev, it will do what you want from userspace.

For regular file, I do agree with you.  But for device node, I don't see
anything wrong by create it directly from kernel space.
In fact, I do not understand why proc_mknod() is removed from
2.6.x ... I will be happy if someone can tell me why.

Why I want to use proc_mknod() in driver ?  I write a small package, ovi-dev,
which can be downloaded from
http://www.sourceforge.net/projects/ovi
The ovi-dev will scan the PCI bus and if it found, eg, 3 PCI devices, it
will create 3 device entries (nodes) automatically at module load time.
So number of device entries (nodes) will match number of devices
of the system ... well, UNIX/Linux doesn't work that way ... there are a lot
of device entries ... but no corresponding hardware existed.

The proc_mknod() can fix the problems ... but it was removed from 2.6.x ...
too bad ... at least for me.   So I'm looking for an alternative way to create
device entry under /dev from drivers instead of /proc ... but still don't know
how.   Anyone know how to do that ?  It should be done at module_init()
and the entry should be removed at module_exit().


Thanks
KC








> 
> Erik
> 
> --
> +-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
> | Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
>
