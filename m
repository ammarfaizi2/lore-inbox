Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965469AbWIRGUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965469AbWIRGUT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 02:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965466AbWIRGUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 02:20:18 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:44930 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S965469AbWIRGUR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 02:20:17 -0400
Subject: Re: bluetooth oops during resume from ram
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, maxk@qualcomm.com,
       bluez-devel@lists.sourceforge.net
In-Reply-To: <20060917193659.GB2973@elf.ucw.cz>
References: <20060917140952.GA3349@elf.ucw.cz>
	 <1158511979.24941.1.camel@localhost>  <20060917193659.GB2973@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 08:20:11 +0200
Message-Id: <1158560411.30486.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> > > If I suspend-to-RAM with usb active on thinkpad x60, I get an
> > > oops. Machine works okay after that, but...
> > > 
> > > it seems bluetooth is scribbling over more memory than was allocated
> > > (?)
> > 
> > not that I am aware of. Is this a plain 2.6.18-rc6 or did you apply
> > additional patches that might have caused this behavior?
> 
> I have some additional changes, but they should not affect this...
> 
> OTOH, I probably used this script:
> 
> 
> killall hciattach
> sleep .1
> setserial /dev/ttyBT baud_base 921600

whatever that is for. I thought the ttyBT was iPAQ specific or something
like that.

> hciattach -s 921600 /dev/ttyS0 bcsp

This is non-sense for a X60.

> hciconfig hci0 up
> hciconfig hci0 name billionton
> hciconfig /dev/ttyUB1

And what has ttyUB1 to do with it.

> ...even through there's no bluetooth at ttyS0 (as this machine has
> bluetooth on usb).

With my X41 the suspend to/from RAM works without problems.

I think this is something else.

Regards

Marcel


