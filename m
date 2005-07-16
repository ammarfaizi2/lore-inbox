Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVGPQQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVGPQQk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 12:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVGPQQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 12:16:40 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:30573 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261669AbVGPQQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 12:16:25 -0400
Date: Sat, 16 Jul 2005 09:16:20 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Module option for compiled-in parts
Message-Id: <20050716091620.3d812b11.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0507161043470.5993@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0507161043470.5993@yvahk01.tjqt.qr>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jul 2005 10:45:17 +0200 (MEST) Jan Engelhardt wrote:

> Hi,
> 
> 
> I have added a module_param() to a component that is compiled in
> (drivers/char/vt.c). Since it's not a module, will it still show a 
> /sys/module/WhatGoesHere/parameters/myvariablename file? What will be put as 
> "WhatGoesHere" as vt.c does not become vt.ko?

Interesting question.

Are you adding one/some module parameters to vt.c ?
I don't see any there.


I have usbcore built-in (not a loadable module), and I still see
in /sys/module/usbcore/parameters these files:

blinkenlights
old_scheme_first
usbfs_snoop
use_both_schemes

but usbcore is "defined" as containing a list of .o files
in drivers/usb/core/Makefile.

---
~Randy
