Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265045AbUELNRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbUELNRA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 09:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUELNQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 09:16:59 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:29831 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S265050AbUELNQJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 09:16:09 -0400
Subject: Re: [PATCH] hci-usb bugfix
From: Marcel Holtmann <marcel@holtmann.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1084260638.4599.20.camel@localhost>
References: <20040509194715.GA2163@eniac.lan.yath.eu.org>
	 <pan.2004.05.09.22.37.55.951344@nn7.de>  <1084185635.4017.5.camel@pegasus>
	 <1084260638.4599.20.camel@localhost>
Content-Type: text/plain
Message-Id: <1084367731.25099.13.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 15:15:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Soeren,

> well, at least I tried like 5 times plugin/out and it did not oops :)

this is good news.

> hmhh why is the device address always incrementing ?

Ask the USB guys. I don't know it.

> > > usb 2-1: USB disconnect, address 4
> > > usb 2-1: new full speed USB device using address 5
> > > devfs_mk_dev: could not append to parent for bluetooth/rfcomm/0
> > > devfs_remove: bluetooth/rfcomm/0 not found, cannot remove
> > > Call trace:
> > >  [c00099c4] dump_stack+0x18/0x28
> > >  [c010af1c] devfs_remove+0xcc/0xd0
> > >  [c01e4a5c] tty_unregister_device+0x30/0x5c
> > >  [f2080b64] rfcomm_dev_destruct+0x50/0xd4 [rfcomm]
> > >  [f2081310] rfcomm_release_dev+0xf8/0x148 [rfcomm]
> > >  [f20807a8] rfcomm_sock_ioctl+0x34/0x58 [rfcomm]
> > >  [c02a8668] sock_ioctl+0xc0/0x2c0
> > >  [c00726e0] sys_ioctl+0x100/0x318
> > >  [c0005d60] ret_from_syscall+0x0/0x44
> > > usb 2-1: USB disconnect, address 5
> > 
> > Do you use DevFS? Does the same problem exists if you disable it and use
> > udev instead?
> 
> ok, so I went to udev and also no oops so far... 

If you still want to use DevFS you have to investigate by yourself,
because DevFS is obsolete and I don't really care about it.

Regards

Marcel


