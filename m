Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275201AbTHGHhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 03:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275202AbTHGHhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 03:37:39 -0400
Received: from mx0.gmx.net ([213.165.64.100]:61435 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S275201AbTHGHhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 03:37:38 -0400
Date: Thu, 7 Aug 2003 09:37:36 +0200 (MEST)
From: Daniel Blueman <daniel.blueman@gmx.net>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
References: <3F319CD5.7060706@pacbell.net>
Subject: Re: [linux-usb-devel] [2.6.0-test2-bk5] OHCI USB printing causing system lockup...
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008973862@gmx.net
X-Authenticated-IP: [194.202.174.101]
Message-ID: <4210.1060241856@www4.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It does seem that it's the usblp driver, and I think the way forward is to
collect more information with compiling the driver with debugging to see more
of what's happening here. I'll do this tonight and report findings.

The module author string is "Michael Gee, Pavel Machek, Vojtech Pavlik,
Randy Dunlap, Pete Zaitcev, David Paschal" - who should I CC my results to?

Thanks!

> Daniel Blueman wrote:
> > When printing a test page on an Epson C62 through an unpowered USB 1.1
> hub,
> > the printer printed part of the page, then stopped.
> > 
> > The 'error -110' messages were being sent to the syslogs, and after
> pulling
> > the connector to the USB hub, the system locked up.
> 
> So it seems like there are two errors:
> 
>   - timeouts during printing, reported recently on UHCI too;
> 
>   - the usb_buffer_free() oops from printer cleanup, likewise.
> 
> Seems more related to the printer driver than to OHCI ...

-- 
Daniel J Blueman

COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post

