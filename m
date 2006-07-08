Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWGHF16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWGHF16 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 01:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWGHF16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 01:27:58 -0400
Received: from xenotime.net ([66.160.160.81]:37768 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751297AbWGHF16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 01:27:58 -0400
Date: Fri, 7 Jul 2006 22:30:43 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Opinions on removing /proc/tty?
Message-Id: <20060707223043.31488bca.rdunlap@xenotime.net>
In-Reply-To: <9e4733910607071956q284a2173rfcdb2cfe4efb62b4@mail.gmail.com>
References: <9e4733910607071956q284a2173rfcdb2cfe4efb62b4@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 22:56:51 -0400 Jon Smirl wrote:

> Does anyone use the info in /proc/tty? The hard coded device names
> aren't compatible with udev's ability to rename things.
> 
> There also doesn't appear to be any useful info in the drivers portion
> that isn't already available in sysfs. I can add some code to make a
> list of registered line disciplines appear in sysfs.
> 
> Does anyone have a problem with deleting /proc/tty if ldisc enum
> support is added to sysfs?
> 
> [root@jonsmirl tty]# cat drivers
> /dev/tty             /dev/tty        5       0 system:/dev/tty
> /dev/console         /dev/console    5       1 system:console
> /dev/ptmx            /dev/ptmx       5       2 system
> /dev/vc/0            /dev/vc/0       4       0 system:vtmaster
> serial               /dev/ttyS       4 64-67 serial
> pty_slave            /dev/pts      136 0-1048575 pty:slave
> pty_master           /dev/ptm      128 0-1048575 pty:master
> unknown              /dev/tty        4 1-63 console
> [root@jonsmirl tty]#
> 
> [root@jonsmirl tty]# cat ldiscs
> n_tty       0

Hi,
I don't know how well this is an answer to your question,
but I would like to be able to find a list of registered "consoles,"
whether they be serial, usbserial, netconsole, lp, or whatever.
/proc/tty/drivers does that partially.

I have a patch that also does it in /proc/consoles:
  http://www.xenotime.net/linux/patches/consoles-list.patch
Is somewhere in /sys the right place to find a list of all consoles?

Thanks,
---
~Randy
