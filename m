Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbVJLXOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbVJLXOv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 19:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbVJLXOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 19:14:51 -0400
Received: from tim.rpsys.net ([194.106.48.114]:47265 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751485AbVJLXOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 19:14:50 -0400
Subject: Re: spitz (zaurus sl-c3000) support
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, zaurus@orca.cx,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051012223036.GA3610@elf.ucw.cz>
References: <20051012223036.GA3610@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 00:14:24 +0100
Message-Id: <1129158864.8340.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-13 at 00:30 +0200, Pavel Machek wrote:
> Hi!
> 
> I got spitz machine today. I thought oz3.5.3 for spitz would be
> 2.6-based, but found out that I'm not _that_ fortunate.

oz 3.5.4 is due for release soon and will hopefully have a 2.6 option
for spitz.

> What's the status of spitz? I see log from 2.6.12-rc boot, and pages
> at http://www.orca.cx/zaurus/ seem to be old...

Its outdated now.

> Is there simple way to tell spitz and tosa apart (like without opening
> the machine)?

At what level? machine_is_spitz() and machine_is_tosa()? There are some
checks in the sharpsl head file to auto detect all the Zaurus machines
and set the machine numbers. For those two machines the difference is
the presence of the tc6393 chip in tosa. See head-sharpsl.S

> Aha, I realized that spitz support came into 2.6.14-rc2, so something
> definitely _is_ happening. Are there newer patches than orca.cx
> somewhere?

I got a spitz recently which moved 2.6 for it forwards a lot. Have a
look at:

http://www.rpsys.net/openzaurus/

This file should give you an idea of which patches to apply in what
order:
http://www.rpsys.net/openzaurus/temp/linux-openzaurus_2.6.14-rc1.bb

With my patch series applied, we're missing usb client (usb host works)
and sound support.

Mainline is missing power management and currently fails to compile
without my patch series but I'm working on that.

Richard

