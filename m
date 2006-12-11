Return-Path: <linux-kernel-owner+w=401wt.eu-S937548AbWLKTB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937548AbWLKTB5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937560AbWLKTB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:01:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:58266 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S937548AbWLKTBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:01:55 -0500
X-Authenticated: #20450766
Date: Mon, 11 Dec 2006 20:01:10 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
cc: Corey Minyard <cminyard@mvista.com>, Tilman Schmidt <tilman@imap.cc>,
       linux-serial@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
In-Reply-To: <20061211102016.43e76da2@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0612111954120.4039@poirot.grange>
References: <4533B8FB.5080108@mvista.com> <20061210201438.tilman@imap.cc>
 <Pine.LNX.4.60.0612102117590.9993@poirot.grange> <457CB32A.2060804@mvista.com>
 <20061211102016.43e76da2@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006, Alan wrote:

> On Sun, 10 Dec 2006 19:23:54 -0600
> Corey Minyard <cminyard@mvista.com> wrote:
> 
> > Nothing has come of this yet.  But we have these two requests and a 
> > request from Russell Doty at Redhat.
> > 
> > It would be nice to know if this type of thing was acceptable or not, 
> > and the problems with the patch.  The patch is at 
> > http://home.comcast.net/~minyard
> 
> This looks wrong. You already have a kernel interface to serial drivers.
> It is called a line discipline. We use it for ppp, we use it for slip, we
> use it for a few other things such as attaching sync drivers to some
> devices.

Alan, my understanding might be wrong, but, I think, line disciplines are 
there as "protocols" for user-tty interfaces, i.e., you need a user, that 
opens a tty, sets a line discipline to it, and does io (read/write) over 
it, and NOT to be completely initialised and driven from the kernel. 
Whereas, what some users need is a complete in-kernel interface, when 
either another driver (like in case with the previous poster), or the 
platform code (linkstation) know that there's a device attached to this 
UART, know how and WHEN to operate it, and the user doesn't care about it 
at all. Think of it as about, say, i2c devices, that have user device 
interface and in-kernel interface, to which you can connect rtc, USB 
transceivers, that get controlled completely from the kernel TRANSPARENTLY 
for the user.

Thanks
Guennadi
---
Guennadi Liakhovetski
