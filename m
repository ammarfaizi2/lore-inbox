Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263436AbTC2QJH>; Sat, 29 Mar 2003 11:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263437AbTC2QJG>; Sat, 29 Mar 2003 11:09:06 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:61374 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S263436AbTC2QJC>; Sat, 29 Mar 2003 11:09:02 -0500
Date: Sat, 29 Mar 2003 08:31:51 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: netchip's net2280 usb 2.0 device
To: Kallol Biswas <kallol.biswas@efi.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E85CA77.2020301@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>      We have been using the net2280 chip (usb 2.0) as a usb target
> printer device. We have been seeing data corruption problems
> during a bulk out transfer when data is taken out the device
> quite slow.  The corruption size is only 4 bytes suggesting
> a device problem. Is anyone using this chip and has anyone
> encountered similar problem?

I've certainly been using it ... there's a Linux driver for it,
part of a "USB Gadget" framework that could support other such
"target mode" hardware, at http://kernel.bkbits.net/~david-b
for general use.  (Download from BK, the 2.5.64 patch doesn't
include the net2280 driver and there's no 2.4 patch yet.  I'll
send out an announcement soon, when I update the patches.)

I haven't run into that particular problem, but it sounds
like it might be a known erratum ... have you asked NetChip, or
checked the 14-March errata at their website?  They've been
pretty responsive to my questions.


> Is there any other 2.0 usb chip that can be used as a target mode
> device?

The net2280 is the only such chip I know of that talks PCI
directly.  So it's particularly Linux-friendly:  it doesn't
need special bus adapter hardware.

- Dave


