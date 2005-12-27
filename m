Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbVL0Wxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVL0Wxv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 17:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVL0Wxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 17:53:51 -0500
Received: from sd291.sivit.org ([194.146.225.122]:28169 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S932380AbVL0Wxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 17:53:50 -0500
Subject: Re: [RFT] Sonypi: convert to the new platform device interface
From: Stelian Pop <stelian@popies.net>
To: dtor_core@ameritech.net
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d5000512271418m26d3da41s18a3f97470eda912@mail.gmail.com>
References: <200512130219.41034.dtor_core@ameritech.net>
	 <d120d5000512131104x260fdbf2mcc58fb953559fec5@mail.gmail.com>
	 <Pine.LNX.4.61.0512252207020.15152@yvahk01.tjqt.qr>
	 <200512251617.09153.dtor_core@ameritech.net>
	 <Pine.LNX.4.61.0512271859240.3068@yvahk01.tjqt.qr>
	 <d120d5000512271418m26d3da41s18a3f97470eda912@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 27 Dec 2005 23:53:36 +0100
Message-Id: <1135724016.23182.5.camel@deep-space-9.dsnet>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 27 décembre 2005 à 17:18 -0500, Dmitry Torokhov a écrit :

> > However, there are some things that remain unresolved:
> > - the "mousewheel" reports only once every 2 seconds when constantly
> >  wheeling (in mev)

could be because scrolling the wheel generates several kinds of events
(up, down but also fast up, fast down etc), and only some of them get
interpreted. Verify the events by using the verbose=1 parameter.

> > - pressing the jogdial button produces a keyboard event (keycode 158)
> >  rather than a mousebutton 3 event
> >
> 158 is KEY_BACK and is generated on type2 models.. If you load the
> driver with verbose=1 what does it say when you press jog dial?

If you don't have a Back button then you can adjust the 'mask' module
parameter in order to detect only the events you are interested in. And
before you ask yes, Sony reused the same codes for several types of
events...

> > BTW, how can I use the Fn keys on console (keycodes 466-477) for arbitrary
> > shell commands?
> > Such a feature, among which special combinations like Ctrl+Alt+Del also
> > belong, are handled by the kernel which leaves almost no room for
> > user-defined userspace action. Any idea?
> >
> There are daemons that read corersponding /dev/input/eventX and act on
> it. The in-kernel keyboard driver ignores keycodes above 255.

And also daemons more sonypi specific which read /dev/sonypi instead,
like sonypid, sonypidd, jogdiald, kde etc.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

