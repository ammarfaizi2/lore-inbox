Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTDHQDr (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbTDHQDr (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:03:47 -0400
Received: from air-2.osdl.org ([65.172.181.6]:36261 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261872AbTDHQDn (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 12:03:43 -0400
Date: Tue, 8 Apr 2003 09:14:56 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ed Tomlinson <tomlins@cam.org>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.67-mm1
Message-Id: <20030408091456.48015790.rddunlap@osdl.org>
In-Reply-To: <200304081139.58218.tomlins@cam.org>
References: <20030408042239.053e1d23.akpm@digeo.com>
	<200304080917.15648.tomlins@cam.org>
	<20030408083153.5dec0d0e.rddunlap@osdl.org>
	<200304081139.58218.tomlins@cam.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Apr 2003 11:39:58 -0400 Ed Tomlinson <tomlins@cam.org> wrote:

| On April 8, 2003 11:31 am, Randy.Dunlap wrote:
| > On Tue, 8 Apr 2003 09:17:15 -0400 Ed Tomlinson <tomlins@cam.org> wrote:
| > | Hi,
| > |
| > | This does not boot here.  I loop with the following message.
| > |
| > | i8042.c: Can't get irq 12 for AUX, unregistering the port.
| > |
| > | irq 12 is used (correctly) by my 20267 ide card.  My mouse is
| > | usb and AUX is not used.
| > |
| > | Ideas?
| >
| > I guess that's due to my early kbd init patch.
| > So why do you have i8042 configured into your kernel?
| 
| One, What exactly configures it?  Two my keyboard is not usb, just
| my mouse.

CONFIG_SERIO=y
CONFIG_SERIO_I8042=y

Is your keyboard PS/2 or PC-AT-like, or something else?

| > The loop doesn't terminate?  Do you get the same message (above)
| > over and over again?
| 
| Yes, until I trigger a reboot (SysReq+B).

Interesting.  If I force that register IRQ 12 to fail, I just get this
one time:

i8042.c: Can't get irq 12 for AUX, unregistering the port.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1


Just saw Andrew's email...

--
~Randy
