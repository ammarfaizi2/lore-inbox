Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbTIPCg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 22:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbTIPCg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 22:36:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:13991 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261762AbTIPCg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 22:36:27 -0400
Date: Mon, 15 Sep 2003 19:36:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: M M <mokomull@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.0-test5 Refuses to Boot (ceases after "mice: PS/2
 mouse device common for all mice")
Message-Id: <20030915193657.483fd953.akpm@osdl.org>
In-Reply-To: <20030916011825.98277.qmail@web41806.mail.yahoo.com>
References: <20030916011825.98277.qmail@web41806.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M M <mokomull@yahoo.com> wrote:
>
> I've downloaded, configured (make oldconfig using
> .config from 2.4.21), and compiled kernel 2.6.0-test5,
> but it just refuses to boot completely.
> 
> It prints:
> drivers/usb/core/usb.c: registered new driver hid
> drivers/usb/input/hid-core.c: v2.0:USB HID core driver
> mice: PS/2 mouse device common for all mice
> 
> and just stops booting.
> 
> Which configuration option(s) did I miss?

Please add `initcall_debug' to your kernel boot comand line.  You will see
a lot of lines of the form "calling initcall 0xNNNNNNNN".  Write down the
final address, reboot and look it up in System.map.

Also try disabling ACPI.

