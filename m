Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWGIXRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWGIXRR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 19:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWGIXRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 19:17:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5549 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932485AbWGIXRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 19:17:16 -0400
Date: Sun, 9 Jul 2006 16:17:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org, efault@gmx.de
Subject: Re: 2.6.18-rc1-mm1: /sys/class/net/ethN becoming symlink befuddled
 /sbin/ifup
Message-Id: <20060709161712.c6d2aecb.akpm@osdl.org>
In-Reply-To: <44B189D3.4090303@imap.cc>
References: <6wDCq-5xj-25@gated-at.bofh.it>
	<6wM2X-1lt-7@gated-at.bofh.it>
	<6wOxP-4QN-5@gated-at.bofh.it>
	<44B189D3.4090303@imap.cc>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 00:57:23 +0200
Tilman Schmidt <tilman@imap.cc> wrote:

> On 09.07.2006 23:00, Andrew Morton wrote:
> 
> > On Sun, 09 Jul 2006 20:22:09 +0200
> > Mike Galbraith <efault@gmx.de> wrote:
> > 
> >>As $subject says, up-to-date SuSE 10.0 /sbin/ifup became confused...
> 
> Same here.
> 
> > I'd be suspecting
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/broken-out/gregkh-driver-network-class_device-to-device.patch.
> > 
> > If you could do a `patch -R' of that one it'd really help, thanks.
> 
> Tried that, but failed with:
> 
>   LD      .tmp_vmlinux1
> net/built-in.o: In function `dev_change_name':
> : undefined reference to `class_device_rename'
> 
> Not sure whether that's an unclean patch reversal because of conflicts
> with other patches (had a few "fuzz" and "offset" messages during the
> patch -R), will have a look tomorrow.
> 

drat, you'll also need to revert
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/broken-out/gregkh-driver-class_device_rename-remove.patch
