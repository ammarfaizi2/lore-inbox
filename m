Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267908AbUGaEy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267908AbUGaEy2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 00:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267907AbUGaEy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 00:54:28 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:6584 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267908AbUGaEy0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 00:54:26 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: input system: EVIOCSABS(abs) ioctl disabled, why?
Date: Fri, 30 Jul 2004 23:54:25 -0500
User-Agent: KMail/1.6.2
Cc: Kristian =?iso-8859-1?q?H=F8gsberg?= <krh@bitplanet.net>,
       Vojtech Pavlik <vojtech@suse.cz>, Olav Kongas <olav@enif.ee>
References: <Pine.LNX.4.58.0407281453560.16069@serv.enif.ee> <20040728134313.GB4831@ucw.cz> <410B0486.6060706@bitplanet.net>
In-Reply-To: <410B0486.6060706@bitplanet.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407302354.25041.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 July 2004 09:31 pm, Kristian Høgsberg wrote:
> Vojtech Pavlik wrote:
> > On Wed, Jul 28, 2004 at 03:41:28PM +0300, Olav Kongas wrote:
> > 
> > 
> >>When trying to feed calibration information to a touchscreen driver with
> >>the EVIOCSABS(abs) ioctl command, I noticed that this command is disabled
> >>in 2.6.7. Only after the modification given in the patch below it was
> >>possible to use this ioctl command.
> >>
> >>Why is the EVIOCSABS command disabled? I cannot imagine that nobody uses
> > 
> > 
> > It's a bug. I'll fix it.
> 
> On a related note - shouldn't there also be a EVIOCSLED, or am I missing 
> something obvious?  How do you set keyboard LEDs?
> 

I think you can use KDSKBLED/KDSETLED ioctls, but I agree that that evdev
should also provide access to the same functions.

-- 
Dmitry
