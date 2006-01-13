Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWAMEYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWAMEYw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 23:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWAMEYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 23:24:51 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:28021 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964799AbWAMEYv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 23:24:51 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: unify sysfs device tree
Date: Thu, 12 Jan 2006 23:24:49 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <20060113015652.GA30796@vrfy.org>
In-Reply-To: <20060113015652.GA30796@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601122324.49442.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006 20:56, Kay Sievers wrote:
> Here is for illustration the "input" layer as a flat /sys/class directory. All
> devices point to /sys/devices which exposes the device hierarchy if userspace
> wants to know that:
>         /sys/class/
>         ...
>         |-- input
>         |   |-- input0 -> ../../devices/platform/i8042/serio1/input0
>         |   |-- input1 -> ../../devices/platform/i8042/serio0/input1
>         |   |-- input3 -> ../../devices/platform/i8042/serio0/serio2/input3
>         |   |-- input4 -> ../../devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/input4
>         |   |-- mice -> ../../devices/mice
>         |   |-- mouse0 -> ../../devices/platform/i8042/serio0/input1/mouse0
>         |   |-- mouse1 -> ../../devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/input4/mouse1
>         |   `-- mouse2 -> ../../devices/platform/i8042/serio0/serio2/input3/mouse2

Looks nice with exception of my standard argument that inputX and
mouseX are objects of different (but related) classes.

I believe this also relies on overriding class' methods (release, uevent)
by individual devices and inability for class to define standard attributes
for such devices. Pretty yucky...

-- 
Dmitry
