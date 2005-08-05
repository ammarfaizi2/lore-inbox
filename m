Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262921AbVHEIep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbVHEIep (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 04:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbVHEIeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 04:34:44 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:39833 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262913AbVHEIdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 04:33:35 -0400
Date: Fri, 5 Aug 2005 10:33:13 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Vadim Yatsenko <Vadim.Yatsenko@malva.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: initrd load from any block device
In-Reply-To: <dcv4h8$98n$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.61.0508051028240.26367@yvahk01.tjqt.qr>
References: <dcv4h8$98n$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>May be it was discussed but I havn't answer.
>So my question is: why only supported media to load
>initial ramdisk is floppy?

Who said that? Linux LiveCDs all load it from CD, and since the kernel 
provides initramfs, the initrd can also be loaded from within the kernel 
itself.

>In embedded systems it's more other suitable devices
>such as mtdblock, etc. So why not to add some code
>to support loading compressed initrd images from
>any block device. It's can reduce boot up time.

Though, I am seeing your point. The initrd= option does not seem to take block 
devices, so this must be a bootloader feature - because the bootloader needs 
to load the initrd into some memory location so the kernel can play with 
afterwards.

>It is usual practice in embedded world to use ramdisk
>as a root.
>Any comments?

root=/dev/ram0 initrd=somefile_on_the_iso init=/my_favorite_file_in_the_initrd

Works wonders.


Jan Engelhardt
-- 
