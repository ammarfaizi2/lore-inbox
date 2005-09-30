Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbVI3DJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbVI3DJl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 23:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVI3DJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 23:09:41 -0400
Received: from xenotime.net ([66.160.160.81]:11182 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751341AbVI3DJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 23:09:41 -0400
Date: Thu, 29 Sep 2005 20:09:38 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Emmanuel Fleury <fleury@cs.aau.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Framework for automatic Configuration of a Kernel
Message-Id: <20050929200938.779ce6e2.rdunlap@xenotime.net>
In-Reply-To: <43396A6A.30104@cs.aau.dk>
References: <20050927125300.24574.qmail@web51014.mail.yahoo.com>
	<43396A6A.30104@cs.aau.dk>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005 17:51:06 +0200 Emmanuel Fleury wrote:

> Ahmad Reza Cheraghi wrote:
> > 
> > Again another good Idea. Your right;-) Its better. 
> > But it better getting another way of detecting the
> > Hardware/Software etc. from the System without using
> > lspci or the proc-files...? Something that gets all
> > the Hardware Information directly from the I/O and not
> > from the Kernel. The good thing about lspci is that it
> > does both . But it doesnt say if there is  a CDROM or
> > floppy-disc... I tryed alot to search for something
> > like that but without any success. I heard about this
> > Otopia Project. I google after it but I didnt find
> > anything usefule. I think its dead. 
> 
> I might be wrong, but I don't think that there is any other way to get
> hardware information but through the /proc or /sys interface.
> 
> Can somebody comment on this ?

You can use libpciutils (whatever lspci uses) to enumerate
PCI devices  (but I wouldn't, I'd just use lspci :).

You can clone lsusb to enumerate USB devices... but I would
just use lsusb.

You can probably clone 'pnpdump' to enumerate ISA PNP devices.
But I would just use pnpdump.

There's probably a ieee1394/firewire enumeration program.

You won't be able (safely) to discover ISA devices/ports.
(other than "standard" cnipset/motherboard devices)

Anyway, I would just use the existing tools unless there are
things that you must have that they don't provide.

---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
