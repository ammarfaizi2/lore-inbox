Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267566AbUJDMb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267566AbUJDMb4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 08:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267508AbUJDMb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 08:31:56 -0400
Received: from dialpool2-4.dial.tijd.com ([62.112.11.4]:1920 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S268094AbUJDM3r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 08:29:47 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc3] suspend-to-disk oddities
Date: Mon, 4 Oct 2004 14:22:24 +0200
User-Agent: KMail/1.7
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net
References: <200410041107.12049.lkml@kcore.org> <200410041359.07047.lkml@kcore.org> <200410041406.40222.oliver@neukum.org>
In-Reply-To: <200410041406.40222.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200410041422.25395.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 October 2004 14:06, Oliver Neukum wrote:
> Am Montag, 4. Oktober 2004 13:59 schrieb Jan De Luyck:
> > On Monday 04 October 2004 13:31, Oliver Neukum wrote:
> > > Am Montag, 4. Oktober 2004 11:07 schrieb Jan De Luyck:
> > > > Just tried swsusp, works great, besides a few strange things:
> > > >
> > > > - The suspend routine is unable to shutdown the mysqld process:
> > > >
> > > > Oct  4 10:19:43 precious kernel: Stopping tasks:
> > > > ================================================= Oct  4 10:19:43
> > > > precious kernel:  stopping tasks failed (1 tasks remaining) Oct  4
> > > > 10:19:43 precious kernel: Restarting tasks...<6> Strange, mysqld not
> > > > stopped Oct  4 10:19:43 precious kernel:  done
> > > >
> > > > - USB subsystem is totally unworking until I reinitialise it (using
> > > > /etc/init.d/hotplug restart)
> > >
> > > Precisely how does it fail?
> >
> > This is after a successfull suspend-resume.
> >
> > It doesn't work, period. No messages in the logs, anything I plug in
> > isn't reacted to, lsusb gives nothing. It's just 'not there'.
>
> Does "cat /proc/bus/usb/devices" give you an empty file or does it hang?
> Is that modular USB or is it compiled into the kernel? OHCI or UHCI?

UHCI. I just did a test-suspend-resume, currently plugged USB devices don't work, but it does show up in the devices file. It also responds to replugging.... I don't get it.
 I had no response whatsoever earlier. Mouse doesn't work until replugged, lots of messages like this in dmesg:

Oct  4 14:16:49 precious kernel: drivers/usb/input/hid-core.c: input irq status -84 received
Oct  4 14:16:54 precious last message repeated 209 times

Jan
-- 
BOFH excuse #285:

Telecommunications is upgrading. 
