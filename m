Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269737AbUISDnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269737AbUISDnn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 23:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269738AbUISDnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 23:43:42 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:38542 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269737AbUISDnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 23:43:40 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Logitech and Microsoft Tilt Wheel Mice. Driver suggestions wanted.
Date: Sat, 18 Sep 2004 22:43:37 -0500
User-Agent: KMail/1.6.2
Cc: mike cox <mikecoxlinux@yahoo.com>
References: <20040919032613.96799.qmail@web52805.mail.yahoo.com>
In-Reply-To: <20040919032613.96799.qmail@web52805.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409182243.37138.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 September 2004 10:26 pm, mike cox wrote:
> 
> --- Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> 
> > On Saturday 18 September 2004 08:51 pm, mike cox
> > wrote:
> > > I'm modifying Vojtech Pavlik's 2.6.8.1 kernel
> > > mousedev.c mouse driver to support the new "Tilt
> > > wheel" functionality on the Logitech MX1000 Laser
> > > Mouse, and the Microsoft Wireless Optical mouse
> > with
> > > Tilt Wheel Technology.
> > 
> > How will the tilt information be exported? And what
> > is wrong with using
> > event interface? I think that the evdev patches are
> > included into X shipped
> > by Gentoo, Mandrake and Fedora at least...
> 
> I'm using SuSE 8.2 with the 2.6.8.1 kernel.  I ran xev
> on my machine and it didn't detect any tilting at all.
>

Evdev (dev/input/eventX) is the new way of communicating input events
to userspace. It allows input devices pass much more precise information
about their state and it is quite extensible. There are patches for XFree86 
and X.org that evdev-ify X mouse and keyboard driver. I will try Google
for them later. They are pretty new, SuSE 8.2 would not have them.

Mousedev is a legacy interface and is very inflexible. I mean there are mice
with more than 5 muttons, many wheels etc etc; data that is impossible to fit
into PS/2 procotol. Look for example at wacom or synaptics drivers to see what
kind of information can be passed through evdev.

-- 
Dmitry
