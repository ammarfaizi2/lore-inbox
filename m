Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWFMQ1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWFMQ1A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 12:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWFMQ1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 12:27:00 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:32730 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932177AbWFMQ07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 12:26:59 -0400
Date: Tue, 13 Jun 2006 13:26:55 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: Mark Lord <lkml@rtr.ca>, Greg KH <gregkh@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb,
 error -28
Message-ID: <20060613132655.03bcc1d3@doriath.conectiva>
In-Reply-To: <20060613114604.GB10834@fks.be>
References: <448DC93E.9050200@rtr.ca>
	<20060612204918.GA16898@suse.de>
	<448DD50F.3060002@rtr.ca>
	<448DC93E.9050200@rtr.ca>
	<20060612204918.GA16898@suse.de>
	<448DD968.2010000@rtr.ca>
	<20060612212812.GA17458@suse.de>
	<448DE28D.3040708@rtr.ca>
	<448DF6F6.2050803@rtr.ca>
	<20060613114604.GB10834@fks.be>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.3 (GTK+ 2.9.2; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006 13:46:06 +0200
Frank Gevaerts <frank.gevaerts@fks.be> wrote:

| On Mon, Jun 12, 2006 at 07:21:26PM -0400, Mark Lord wrote:
| > Mark Lord wrote:
| > >Greg KH wrote:
| > >>So we should have finally covered both of them now.
| > >
| > >Yes, agreed.
| > >
| > >So if modify pl2303_open() to have it simulate -ENOMEM from 
| > >usb_submit_urb(),
| > >then this should not crash the entire USB subsystem.  Right?
| > >
| > >Ditto if it happens due to low-memory, rather than me hacking the code 
| > >to test it?
| > 
| > Mmmm.. looks like it's still buggy, but we manage to avoid the bug
| > under *most* circumstances.   Which is good!
| > 
| > But the bug will still need to be fixed.  A failure from usb_submit_urb()
| > should not require a reboot to recover.
| > Here's the results of a simulated -ENOMEM test:
| > 
| > kernel BUG at kernel/workqueue.c:110!
| 
| We had the exact same error here with ipaq.ko. Our problems only went
| away once we applied the following (the first part might already be
| applied).

 Interesting, I couldn't reproduce this with ftdio_sio.

 (and unfortunatally I'm w/o my pl2303 device).

-- 
Luiz Fernando N. Capitulino
