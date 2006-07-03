Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWGCUYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWGCUYg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWGCUYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:24:36 -0400
Received: from terminus.zytor.com ([192.83.249.54]:25269 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750759AbWGCUYf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:24:35 -0400
Message-ID: <44A97CFF.9040609@zytor.com>
Date: Mon, 03 Jul 2006 13:24:31 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, guilhermedestefani@gmail.com
Subject: Re: Documentation/initrd.txt update
References: <1151945437.5699.13.camel@homemfera.perkons.net>
In-Reply-To: <1151945437.5699.13.camel@homemfera.perkons.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guilherme Destefani wrote:
> The cpio initrd isn't documented in
> linux-2.6.17/Documentation/initrd.txt.
> (but it is in
> linux-2.6.17/Documentation/filesystems/ramfs-rootfs-initramfs.txt)
> initrd.txt shouldn't be updated?
> 
> Two possible updates follow, use patch -p1 inside the kernel tree.

... and both are wrong.

initramfs != initrd, plus you specified -c to cpio, which is wrong (-H 
newc is correct).

You have to account for the differences between initramfs and initrd, 
e.g. no pivot_root in initramfs.

	-hpa
