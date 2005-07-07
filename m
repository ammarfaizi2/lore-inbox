Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVGGVk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVGGVk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVGGVku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:40:50 -0400
Received: from web81309.mail.yahoo.com ([206.190.37.84]:10909 "HELO
	web81309.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261486AbVGGVj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:39:59 -0400
Message-ID: <20050707213958.84153.qmail@web81309.mail.yahoo.com>
Date: Thu, 7 Jul 2005 14:39:58 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Synaptics Touchpad not detected in 2.6.13-rc2
To: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor@mail.ru>
In-Reply-To: <20050707212855.GA2871@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Thu, Jul 07, 2005 at 11:24:43PM +0200, Mattia Dongili wrote:
> > On Thu, Jul 07, 2005 at 01:02:38PM -0700, Dmitry Torokhov wrote:
> > > Mattia Dongili <malattia@gmail.com> wrote:
> > [...]
> > > > This is the device (on a Vaio GR), which other info could I provide to
> > > > better diagnose the problem?
> > > > 
> > > 
> > > Could you please do "echo 1 > /sys/modules/i8042/parameters/debug";
> > > reload psmouse module and send me dmesg please?
> > 
> > oh, it seems I'm not able to reproduce the error anymore!
> > I need some rest now, I'll try again tomorrow morning (I must be missing
> > something stupid right now) and report to you again.
>  
> Could be the enabled debug is adding extra delay, making the problem
> impossible to reproduce. IIRC, we've seen this with an ALPS pad, too,
> Dmitry, right?
> 

It was just a tad different - on one of the boxes alps-resume-typo
patch worked only with debug. 2 other boxes worked just fine without
debug.

I just can't see what could be wrong with ps2_adjust_timeout()...
It only reduces timeout to 100 ms when doing reset, exactly like
the old code did. Vojtech, can you see anything there?
 
-- 
Dmitry
