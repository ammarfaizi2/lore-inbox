Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWAESLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWAESLq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWAESLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:11:46 -0500
Received: from mail.gmx.net ([213.165.64.21]:37804 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932134AbWAESLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:11:46 -0500
X-Authenticated: #4399952
Date: Thu, 5 Jan 2006 19:11:45 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Olivier Galibert <galibert@pobox.com>,
       Heikki Orsila <shd@modeemi.cs.tut.fi>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: [OT] ALSA userspace API complexity
Message-ID: <20060105191145.733c1b21@mango.fruits.de>
In-Reply-To: <43BD3AAC.9000104@gmail.com>
References: <20060105140155.GC757@jolt.modeemi.cs.tut.fi>
	<Pine.LNX.4.61.0601051518370.10350@tm8103.perex-int.cz>
	<20060105145101.GB28611@dspnet.fr.eu.org>
	<43BD3AAC.9000104@gmail.com>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2006 20:26:36 +0500
"Alexander E. Patrakov" <patrakov@gmail.com> wrote:

> Olivier Galibert wrote:
> 
> > Make simple things simple, guys.
> 
> Sorry for hijacking the thread, but it is very true. ALSA is just too 
> flexible so that the ALSA equivalent (if it indeed exists) of 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=339951 cannot be fixed. 
> OSS allows specification of device name, and one can set up udev rules 
> so that e.g. /dev/dsp-creative it is always a symlink to a SB PCI sound 
> card and /dev/dsp-fortemedia is for FM801. Then one can tell xine to 
> play sound through /dev/dsp-fortemedia. ALSA accepts only numbers in its 
> plughw:x,y,z notation, and applications are unfixable when kernel device 
> numbers become random.

maybe i misunderstood your point, but:

a] every alsa driver can have an option "index" which tells it what card
number to grab, so either pass it as module load option or at kernel
boot time..

b] applications should actually allow the user to enter _any_ string as
a device name (well "any" is actually too much). This enables the user
to define his own pcm devices (i.e. using alsa pcm LADSPA plugin) and
use these in any native ALSA app.

There's all kind of nifty predefined pcm device definitions available,
as i.e. "surround50", "surround51", etc.. One can even indicate what
card number to use, i.e. "surround50:0" or "surround50:2" (for the first
and third card in the system respectively). The special name "!default"
can also be overridden easily to make any sane and well programmed ALSA
app use a certain pcm device of the user's choice.

If i completely missed your point -> sorry

Flo


-- 
Palimm Palimm!
http://tapas.affenbande.org
