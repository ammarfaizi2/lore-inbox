Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWHNBdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWHNBdT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 21:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWHNBdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 21:33:19 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:29271 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751781AbWHNBdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 21:33:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Osiy19ba2UL4lJizYluiGG5TehOfuFthzjRhXd8DoUdCG0MhbYSbLCaxu1HKhxaEiHMfVz9pKuloI3T8wbr0NfjeNxRZeWe51YheD2j2hRcalBgHgNLVRrUVmk5ViSqIkZXVON3mtRMfsvnNc56yZEN7WO4ehsX1PnoPBOERbj0=
Message-ID: <6b4360c80608131833u440d6c73kad5845aaf5ec7db1@mail.gmail.com>
Date: Sun, 13 Aug 2006 20:33:18 -0500
From: "Nick Manley" <darkhack@gmail.com>
To: "Hulin Thibaud" <hulin.thibaud@wanadoo.fr>
Subject: Re: kernel panic - not syncing: VFS - unable to mount root fs on unknown-block
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44DFCF20.9030202@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44DFCF20.9030202@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you meant 2.6.18?  Anyways, I'm not expert but I usually have
problems when using oldconfig.  It seems you have your kernel settings
configured properly and have included all the proper stuff (ext3, ide
drivers) to be built in.  I would try disabling SCSI if you aren't
using it.  Another thing to look at would be your settings in GRUB (or
lilo).  Your particular setup might vary but it should look something
like this...

title Linux 2.6.18
root (hd0,2)
kernel /boot/bzImage-2.6.18 root=/dev/hda3 ro
# you might also have an "initrd" placed here

If you search Google you can find other suggestions as well and also
posting to your distribution's forum might be a good idea too as the
kernel mailing list is usually a place for reporting bugs and
discussing kernel development.  Basically it is a last resort kind of
thing if you can't find the information anywhere else.

On 8/13/06, Hulin Thibaud <hulin.thibaud@wanadoo.fr> wrote:
> Hello !
> I'm trying to compile my own kernel for drivers on two computers, but
> that fails. A the boot, I have this error :
> kernel panic - not syncing: VFS Unable to mount root fs on unknow-block
> (3.69)
>
> I'm using the kernel 2.6.19 with Ubuntu Dapper. I use the old boot
> config and I type make oldconfig, so I don't understand why there are an
> error with the near same configuration.
> I suppose that I must compile not in module but in hard support for my
> IDE chipset, harddisk and file system. Probably, I don't understand how
> do exactly. I do that :
> lspci |grep IDE
> 0000:00:11.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> make xconfig
> -Device Drivers
> --* ATA/ATAPI/MFM/RLL support
> --- * Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support
> --- * Include IDE/ATA-2 DISK support
> --- * PCI IDE chipset support
> ---- * Generic PCI IDE Support
> ----- * VIA82CXXX chipset support
> - File systems
> -- * Ext3 journalling file system support
> --- * Ext3 extended attributes
> ---- * Ext3 POSIX Access Control Lists
> ---- * Ext3 Security Labels
>
> Have I forgot anything ?
>
> Thanks very much,
> Thibaud.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
