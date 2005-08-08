Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVHHOT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVHHOT5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVHHOT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:19:56 -0400
Received: from alpha.polcom.net ([217.79.151.115]:961 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S932077AbVHHOT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:19:56 -0400
Date: Mon, 8 Aug 2005 16:19:50 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: Re: [PATCH - RFC] Move initramfs configuration to "General setup"
In-Reply-To: <20050808135936.GA9057@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.63.0508081610400.29195@alpha.polcom.net>
References: <20050808135936.GA9057@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, Sam Ravnborg wrote:

> At present the configuration items for initramfs is located in:
> Device drivers | Block Drivers | xxx
>
> This is maybe not the most natural place to have it.
> So with the following patch it is moved below "General setup",
> and relevant config items are collected in a file with a new
> home in usr/.
>
> The original reason why I looked into this is the upcoming merge of klibc
> and I missed a good place to include the KLIBC relevant config options.
> With the Kconfig file added to usr/ is will be a simple menuconfig
> in here for all the KLIBC relevant config options.
>
> Any comments?

>From my recent experiments it looks like in order to be able to use 
initramfs not compiled into the kernel image but loaded from separate file 
by GRUB or LILO one must also build initrd into the kernel.

Am I right? If so, could somebody split initramfs and initrd (not only at 
configuration level but also at code level)? Shouldn't they be separated 
(and possibly initrd removed after some time)? In the mean time it should 
be documented in *config help.

Also somebody should add more documentation about initramfs (generating, 
writing scripts, producing image, the right method for chroot / pivot_root 
/ ...). It took me whole week to find it out myself and I still have some 
doubths...


Thanks,

Grzegorz Kulewski
