Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266364AbUGOV3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266364AbUGOV3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 17:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266365AbUGOV3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 17:29:08 -0400
Received: from mail.enyo.de ([212.9.189.167]:16650 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S266364AbUGOV3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 17:29:04 -0400
To: linux-thinkpad@linux-thinkpad.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: ACPI Hibernate and Suspend Strange behavior
 2.6.7/-mm1
References: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com>
	<1089054013.15671.48.camel@dhcppc4>
	<pan.2004.07.06.14.14.47.995955@physik.hu-berlin.de>
	<slrncfb55n.dkv.jgoerzen@christoph.complete.org>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Thu, 15 Jul 2004 23:29:02 +0200
In-Reply-To: <slrncfb55n.dkv.jgoerzen@christoph.complete.org> (John
 Goerzen's message of "Wed, 14 Jul 2004 20:16:55 +0000 (UTC)")
Message-ID: <87oemhot7l.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Goerzen:

> I'm glad I'm not the only one that is suspecting that.  I just tried
> switching my T40p from APM to ACPI.  I got suspending to RAM working in
> ACPI, but noticed that when I got it back out of my laptop bag later, it
> was physically warm to the touch.

Oh.  My expriences, starting with 2.6.7 with ACPI, are as following:

  - Suspend to RAM is triggered, for example by closing the lid.

  - If it's under X11, the system does not come back.  Display powers
    up, but it remains black.  There is some HDD activity, so it's
    probably still running.  Next time I should check if the IP stack
    is still running.

  - After terminating the X11 server, other devices on the sharded IRQ
    11 are dead (most prominently, e1000 and USB).

This is a T40p.  Behavior with 2.6.8-rc1 is apparently the same.

Any ideas what to try next?
