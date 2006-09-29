Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161555AbWI2JNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161555AbWI2JNf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 05:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161556AbWI2JNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 05:13:35 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:31831 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1161555AbWI2JNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 05:13:34 -0400
Message-ID: <451CE3B8.70706@tls.msk.ru>
Date: Fri, 29 Sep 2006 13:13:28 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Thunderbird 1.5.0.5 (X11/20060813)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Stephan Wiebusch <stephanwib@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: Initrd and ramdisk support
References: <200609282147.41671.stephanwib@t-online.de> <Pine.LNX.4.61.0609291008170.20243@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0609291008170.20243@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> Unpacking initramfs...<0>Kernel panic - not syncing: bad gzip magic numbers
>> Unpacking initramfs...<0>Kernel panic - not syncing: no cpio magic
>>
>> i luckily was able to determine the malefactor. There was the initrd support 
>> built into the kernel while the ramdisk driver was just built as a module.
>>
>> Is it senseful to have the possibility to built the Initramfs/Initrd-support 
>> without having the ramdisk driver forced to be integrated also?
> 
> I hardly see a point in using initrd support without ramdisk. Where would you
> store the initrd on instead?

I build kernels without ramdisk built into, but using initramfs, for quite some
time already.  There was a patch somewhere around 2.6.15 or so, that removed
dependency of INITRD from RAMDISK, just a small Kconfig change.  Now it's in
the mainline.  For initramfs, there's no need for ramdisk - it reads the FS
image from memory (as passed to by loader), and unpacks it into ramfs - no
ramdisk is involved here.

/mjt
