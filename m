Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbTEMGax (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbTEMGaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:30:52 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:63361 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263202AbTEMGa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:30:28 -0400
Date: Mon, 12 May 2003 23:44:15 -0700
From: Andrew Morton <akpm@digeo.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [RFC][TTY] callout removal
Message-Id: <20030512234415.11453a9c.akpm@digeo.com>
In-Reply-To: <20030513062332.GW10374@parcelfarce.linux.theplanet.co.uk>
References: <20030513062332.GW10374@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2003 06:43:08.0561 (UTC) FILETIME=[EA33C010:01C3191A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
>
>         if ((tty->driver.type == TTY_DRIVER_TYPE_SERIAL) &&
>              (tty->driver.subtype == SERIAL_TYPE_CALLOUT)) {
>                  printk("Warning, %s opened, is a deprecated tty "
>                         "callout device\n", tty_name(tty, buf));

google says that one person hit this in 1998.   That's it.

The current message is

	printk(KERN_WARNING "tty_io.c: "
		"process %d (%s) used obsolete /dev/%s - "
		"update software to use /dev/ttyS%d\n",

and google("update software to use") == 201, spread across 1999-2001.

Kill it.
