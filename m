Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUFWV3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUFWV3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266699AbUFWV2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:28:52 -0400
Received: from stgeorges-1-81-56-1-93.fbx.proxad.net ([81.56.1.93]:38634 "EHLO
	garfield") by vger.kernel.org with ESMTP id S266686AbUFWVXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:23:47 -0400
Message-ID: <40D9F4D9.1060002@free.fr>
Date: Wed, 23 Jun 2004 23:23:37 +0200
From: Fabian Fenaut <fabian.fenaut@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: French/France, fr-FR, en
MIME-Version: 1.0
To: George Georgalis <george@galis.org>
CC: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: SIIMAGE sata fails with 2.6.7
References: <20040623163505.GA1068@trot.local> <Pine.GSO.4.33.0406231327060.25702-100000@sweetums.bluetronic.net> <20040623202539.GB3537@trot.local>
In-Reply-To: <20040623202539.GB3537@trot.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you need CONFIG_BLK_DEV_INITRD, otherwise libata and sata_sil
won't be loaded at boot.

George Georgalis wrote:
> I patched 2.6.7 with bk6, configured no SIIMAGE and with 
> SCSI_SATA_SIL. (I got errors with security/selinux/hooks.c so I 
> disabled SELinux)
> 
> I changed "hdc" entries to "sda" in fstab and grub, but on reboot my 
> root, sda1, could not be found. Might it be another device? Or 
> something else? config attached.
> 
> Next attempt will put root on an ata device, but I'm looking to boot
> from sata.
> 
> ------------------------------------------------------------------------
> #
> # Automatically generated make config: don't edit
> #
 > [...]
> # CONFIG_BLK_DEV_INITRD is not set
 > [...]
