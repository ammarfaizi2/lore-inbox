Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270756AbTG0MYj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 08:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270757AbTG0MYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 08:24:39 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:38622 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S270756AbTG0MYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 08:24:38 -0400
Date: Sun, 27 Jul 2003 14:39:47 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: alan@lxorguk.ukuu.org.uk, B.Zolnierkiewicz@elka.pw.edu.pl,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] kill surplus menu in IDE Kconfig
Message-ID: <20030727123947.GC24002@louise.pinerecords.com>
References: <20030726200059.GC16160@louise.pinerecords.com> <Pine.LNX.4.44.0307271425140.717-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307271425140.717-100000@serv>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [zippel@linux-m68k.org]
> 
> > Patch against -bk3.
> 
> Moving up BLK_DEV_HD_ONLY like this is probably not a good idea, it makes 
> everything a submenu of this, what might be confusing.

It's logical though. :)

> Try the patch below instead, it fixes the menu structure, everything which 
> requires BLK_DEV_IDEDMA_PCI is now also under that menu.

Your patch seems to be against test1 vanilla -- it doesn't apply to -bk3.

> +menuconfig IDE

How exactly does menuconfig work, anyway?

It's not a "block command" -> how will kconf know which entries to put
in the submenu?

What if I have

	menuconfig FOO
		bool "foo"

	menuconfig BAR
		bool "bar"

	config BAZ
		bool "baz"
		depends on FOO && BAR

Where is BAZ going to show up and why?

-- 
Tomas Szepe <szepe@pinerecords.com>
