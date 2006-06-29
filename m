Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWF2TFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWF2TFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWF2TFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:05:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46044 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932174AbWF2TFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:05:22 -0400
Date: Thu, 29 Jun 2006 12:05:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm4
Message-Id: <20060629120518.e47e73a9.akpm@osdl.org>
In-Reply-To: <4807377b0606291053g602f3413gb3a60d1432a62242@mail.gmail.com>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	<4807377b0606291053g602f3413gb3a60d1432a62242@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 10:53:03 -0700
"Jesse Brandeburg" <jesse.brandeburg@gmail.com> wrote:

> can't boot 2.6.17-mm4 on x86_64 Intel 7520 platform.
> instant reboot after printing:
>   Booting 'Red Hat Enterprise Linux AS (2.6.17-mm4-jesse)'
> 
> root (hd0,0)
>  Filesystem type is ext2fs, partition type 0x83
> kernel /vmlinuz-2.6.17-mm4-jesse ro root=LABEL=/1 rhgb hdc=none video=atyfb:102
> 4x768M-32@70 console=ttyS0,115200n8 console=tty1 panic=30
>    [Linux-bzImage, setup=0x1e00, size=0x199883]
> initrd /initrd-2.6.17-mm4-jesse.img
>    [Linux-initrd @ 0x37efd000, 0xf2da8 bytes]
> 
> ie no kernel output

Your .config works OK on my x86_64 box.  Wanna swap? ;)

> where should i start to debug?  I can do a bisect pretty easily too
> using git if necessary.

That would be great, thanks.  Your options are to do a git bisect using

git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git#v2.6.17-mm4

(Beware that the mm-to-git trees have had a few problem reports and I'm not
aware of anyone previously using them for a bisect).

or to install quilt and use
http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

