Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbUBAKYd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 05:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUBAKYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 05:24:33 -0500
Received: from news.cistron.nl ([62.216.30.38]:39060 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S265252AbUBAKYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 05:24:32 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: no console with current (bk) kernel
Date: Sun, 1 Feb 2004 10:24:31 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bvik4v$kf9$1@news.cistron.nl>
References: <m3fzdvy0te.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1075631071 20969 62.216.29.200 (1 Feb 2004 10:24:31 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m3fzdvy0te.fsf@lugabout.jhcloos.org>,
James H. Cloos Jr. <cloos@jhcloos.com> wrote:
>From my .config:
>
># CONFIG_FB is not set
>CONFIG_VT=y
>CONFIG_VT_CONSOLE=y
>CONFIG_HW_CONSOLE=y
>CONFIG_VGA_CONSOLE=y
>CONFIG_VIDEO_SELECT=y
>
>and yet the boot fails with a complaint that it cannot open a
>console, followed by a reboot.  (Too fast to copy anything down.)
>
>Box is p3 notebook, gcc is 3.3.2 (gentoo -r5).
>
>What am I missing?

A root filesystem ;)

Looks like the kernel cannot open /dev/console. That means it
got deleted, or you're using the wrong filesystem as root,
or the kernel doesn't include the driver for your fs.

Mike.

