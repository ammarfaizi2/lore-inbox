Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265022AbUGANEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265022AbUGANEK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 09:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbUGANEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 09:04:10 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:9301 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265022AbUGANED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 09:04:03 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marc Waeckerlin <Marc.Waeckerlin@siemens.com>
Subject: Re: Continue: psmouse.c - synaptics touchpad driver sync problem
Date: Thu, 1 Jul 2004 08:03:59 -0500
User-Agent: KMail/1.6.2
Cc: laflipas@telefonica.net, linux-kernel@vger.kernel.org, t.hirsch@web.de,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20040630132305.98864.qmail@web81306.mail.yahoo.com> <200407011434.59340.Marc.Waeckerlin@siemens.com>
In-Reply-To: <200407011434.59340.Marc.Waeckerlin@siemens.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200407010804.00438.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 July 2004 07:34 am, Marc Waeckerlin wrote:
> Dmitry: On synaptics page, I've seen that you've got tons of bugfixes for 
> 2.6.7 on http://www.geocities.com/dt_or/input/2_6_7. Do I need something from 
> there and is there a patch that contains all patches?
>

These are serio sysfs integration patches, they should not change the behavior
of the system.
 
> > >
> > > Well, there are several things:
> > >  1) Cursor hangs on system load with internal mousepad
> > >     (no external mouse connected)
> >
> > You mean when the system load is high? Yes, that can happen..
> 
> System load does not have to be really high, so it happens quite often. This 
> is very disturbing, like in MacOS 15 years ago! (That was one of the main 
> reasons for me not to use Mac, besides the fact that an application could 
> crash the whole system!) I think we now have a multitasking OS, haven't 
> we?!? :-(
> 
> It is sometimes better, sometimes worse, but not really depending on system 
> load, it seems. Just a minute ago it was really bad. Strange.

I usually feel some hesitation in cursor movement under high disk load -
do you experience something like that? Although, now that I think about it,
it's usually not the cursor itself but KDE is lagging to redraw...

> 
> 
> > >  2) Cursor jumps a bit with internal mousepad
> > >     (no external mouse connected)
> > >  3) Cursor jumps like crazy when moving external mouse
> > >  4) Cursor randomly clicks when moving external mouse
> >
> > Has the external mouse ever worked in 2.6? Or is it always
> > just randomly clickng stuff? Have you tried connecting another
> > mouse?
> 
> No and yes. At home I have a wheel mouse, at work a normal PS/2 mouse, both 
> with diffrent keyboards and both with the same problem. I never successfully 
> used an external mouse since I upgraded to SuSE 9.1 (Kernel 2.6). I had no 
> problems with kernel 2.4 and the same hardware.
> 

Just out of curiosity, what happens when you pass psmouse.proto=bare to the
kernel as a boot option (or put "options psmouse proto=bare" in your
/etc/modprobe.conf file if psmouse is compiled as a module)?	

-- 
Dmitry
