Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbTIKWuQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbTIKWuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:50:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:43672 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261484AbTIKWuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:50:11 -0400
Date: Thu, 11 Sep 2003 15:32:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: lgb@lgb.hu, linux-kernel@vger.kernel.org
Subject: Re: horrible usb keyboard bug with latest tests
Message-Id: <20030911153206.1bdee95b.akpm@osdl.org>
In-Reply-To: <20030911233823.A2383@pclin040.win.tue.nl>
References: <20030911125744.89506.qmail@web60207.mail.yahoo.com>
	<20030911134608.GN15818@vega.digitel2002.hu>
	<20030911233823.A2383@pclin040.win.tue.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> wrote:
>
> > For me too, even with a normal keyboard attached to the PS/2 keyboard port.
> > In my case it's very rare, and not a 'constant stick' but short 'pulse' of
> > the same character like displaying 'kkkkkkkkk' in my terminal even if I'm
> > sure that I didn't forget my finger on the key. OK, it's not a showstopper
> > bug, but sometimes annoying. It's 2.6.0-test3 (vanilla).
> 
> Yes, I see this too, but very infrequently.
> 
> For the 2.6 kernels key repeat is not taken from the keyboard but is
> done via a kernel timer, and clearly the code is not quite correct.
> I have not yet been able to detect it before I already
> had hit the next key but maybe somebody else can answer:
> 
> When does this repeat stop?
> Does it stop because the next key has been hit?
> 
> And: does it occur more often when the machine has high load?

It happens to me madly on one of my machines.  The machine is just some
three-year-old PS/2 setup.  It's due to mouse activity.

To reproduce:

1: press and hold a key

2: start moving the mouse in large, rapid circles

3: release the key.

The keystrokes continue to be inserted for an arbitrarily long period: it's
easy to generate thousands of them.  The mouse has to be moved in circles:
moving it from side-to-side causes small stops which allow things to
correct themselves.

It's quite irritating in practice.


