Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUHJJXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUHJJXJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUHJJXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:23:08 -0400
Received: from 23-88.ipact.nl ([82.210.88.23]:56478 "EHLO vt.shuis.tudelft.nl")
	by vger.kernel.org with ESMTP id S262768AbUHJJWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:22:55 -0400
From: Remon <remons_sijrier@vt.shuis.tudelft.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O3
Date: Tue, 10 Aug 2004 11:23:12 +0200
User-Agent: KMail/1.6.2
References: <200408042124.36537.remon@vt.shuis.tudelft.nl> <200408081516.25898.remon@vt.shuis.tudelft.nl> <1091987789.13316.6.camel@mindpipe>
In-Reply-To: <1091987789.13316.6.camel@mindpipe>
Cc: remon_sijrier@vt.shuis.tudelft.nl
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408101123.12503.remons_sijrier@vt.shuis.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 August 2004 07:47, you wrote:
> On Wed, 2004-08-04 at 15:24, Remon Sijrier wrote:
> > Hello,
> >
> > The compilation went fine, but there are some problems I can't solve :-(
> >
> > I had to disable both drm (dri) and acpi to get rid from warning messages
> > but still X doesn't start with the following message in it's log file:
> >
> > xf86OpenSerial cannot open device /dev/psaux no such device
> >
> > This wasn't a problem before. Any help would be appreciated.
> >
> > Thanks,
> >
> > Remon
>
> /dev/psaux is deprecated.  Use /dev/input/mice.  On Debian, you can do
> this with `dpkg-reconfigure xserver-xfree86'.  Otherwise, use your
> distro's X configurator, or edit /etc/X11/XF86Config-4 and replace
> /dev/psaux with /dev/input/mice.

Sorry for being incomplete, but XFree86 cannot find both of them (/dev/psaux 
and /dev/input/mice) when compiled as module
I compiled it in the kernel and now detection is fine.

But using my PS2 mouse is still problematic. It just goes after some time wild 
and jumps back and forth.

Dmesg reports:
psmouse.c mouse out of sync, throwing away 1 (or 2 / 3) bytes

When I disable the IRQ Thread for the mouse it works normal again. Any ideas 
what the problem could be?

Thanks,

Remon
