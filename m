Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWAADnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWAADnm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 22:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWAADnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 22:43:42 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:65491 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750785AbWAADnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 22:43:41 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: "Jiri Slaby" <xslaby@fi.muni.cz>
Cc: Grant Coady <gcoady@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14.5: segfault / oops with ide-scsi
Date: Sun, 01 Jan 2006 14:43:25 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <8qjer1l24hlf3rpl8c9os03pmjb44379dn@4ax.com>
References: <8budr11mfchfp03ncrpqjeck6f04urom8n@4ax.com> <20060101000414.5110A22AEE6@anxur.fi.muni.cz>
In-Reply-To: <20060101000414.5110A22AEE6@anxur.fi.muni.cz>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  1 Jan 2006 01:04:17 +0100, "Jiri Slaby" <xslaby@fi.muni.cz> wrote:

>Grant Coady wrote:
>>Hi there,
>>
>>Got this, trying to mount CDROM on a troublesome box I've not had 
>>for long, Intel ICH 801 / 810 -- this with "hdc=ide-scsi":
>>
>>root@niner:~# mount /dev/sr0 /mnt/cdrom/
>>mount: you must specify the filesystem type
>>root@niner:~# mount -t iso9660 /dev/sr0 /mnt/cdrom/
>>mount: /dev/sr0 is not a valid block device
>>root@niner:~# mount -t iso9660 /dev/sg0 /mnt/cdrom/
>>mount: /dev/sg0 is not a block device
>>root@niner:~# mount -t iso9660 /dev/hdc /mnt/cdrom/
>>Segmentation fault
>>
>>Even if this be finger trouble, it should not oops?
>Could you try the patch below, what does it tell us? Somebody is not setting a
>name of a kobject up.

The patch didn't apply cleanly to 2.6.14.5, so I checked alternatives.

Updating firmware on CDROM seems to have done the trick :o)  Still 
testing, but I've seen it mount a CD now, not done that before (not 
a dual-boot box so cannot get second opinion from win).

Thanks,
Grant.
