Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbTILJOh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 05:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbTILJOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 05:14:37 -0400
Received: from mx0.gmx.de ([213.165.64.100]:3256 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S261342AbTILJOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 05:14:35 -0400
Date: Fri, 12 Sep 2003 11:14:34 +0200 (MEST)
From: Daniel Blueman <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: horrible usb keyboard bug with latest tests
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008973862@gmx.net
X-Authenticated-IP: [194.202.174.101]
Message-ID: <9355.1063358074@www6.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I experienced some problems with the synaptics touchpad on a really old
laptop with linux-2.6.0-test4, where movement detected by the touchpad would
cause a stream of kernel messages to be logged.

I'll test again with test5. I doubt this is related to recent changes with
the posting events to the random pool on key and not mouse movement.

---

Andrew Morton <akpm@osdl.org> wrote in message
news:<uIA4.Pz.7@gated-at.bofh.it>...
> Andries Brouwer <aebr@win.tue.nl> wrote:
> >
> > > For me too, even with a normal keyboard attached to the PS/2 keyboard
port.
> > > In my case it's very rare, and not a 'constant stick' but short
'pulse' of
> > > the same character like displaying 'kkkkkkkkk' in my terminal even if
I'm
> > > sure that I didn't forget my finger on the key. OK, it's not a
showstopper
> > > bug, but sometimes annoying. It's 2.6.0-test3 (vanilla).
> > 
> > Yes, I see this too, but very infrequently.
> > 
> > For the 2.6 kernels key repeat is not taken from the keyboard but is
> > done via a kernel timer, and clearly the code is not quite correct.
> > I have not yet been able to detect it before I already
> > had hit the next key but maybe somebody else can answer:
> > 
> > When does this repeat stop?
> > Does it stop because the next key has been hit?
> > 
> > And: does it occur more often when the machine has high load?
> 
> It happens to me madly on one of my machines.  The machine is just some
> three-year-old PS/2 setup.  It's due to mouse activity.
> 
> To reproduce:
> 
> 1: press and hold a key
> 
> 2: start moving the mouse in large, rapid circles
> 
> 3: release the key.
> 
> The keystrokes continue to be inserted for an arbitrarily long period:
it's
> easy to generate thousands of them.  The mouse has to be moved in circles:
> moving it from side-to-side causes small stops which allow things to
> correct themselves.
> 
> It's quite irritating in practice.

-- 
Daniel J Blueman

COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post

