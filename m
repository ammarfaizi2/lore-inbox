Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbVKXIlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbVKXIlE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 03:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030620AbVKXIlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 03:41:04 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:4031 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1750924AbVKXIlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 03:41:02 -0500
Date: Thu, 24 Nov 2005 09:41:21 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Marc Koschewski <marc@osknowledge.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       340202@bugs.debian.org
Subject: Re: psmouse unusable in -mm series (was: 2.6.15-rc1-mm2 unsusable on DELL Inspiron 8200, 2.6.15-rc1 works fine)
Message-ID: <20051124084120.GA7799@stiffy.osknowledge.org>
References: <20051118182910.GJ6640@stiffy.osknowledge.org> <200511212243.50707.dtor_core@ameritech.net> <20051123195700.GB7446@stiffy.osknowledge.org> <200511232129.35796.tomlins@cam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511232129.35796.tomlins@cam.org>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ed Tomlinson <tomlins@cam.org> [2005-11-23 21:29:35 -0500]:

> On Wednesday 23 November 2005 14:57, Marc Koschewski wrote:
> > * Dmitry Torokhov <dtor_core@ameritech.net> [2005-11-21 22:43:50 -0500]:
> > 
> > > On Sunday 20 November 2005 12:14, Marc Koschewski wrote:
> > > > * Dmitry Torokhov <dtor_core@ameritech.net> [2005-11-18 22:07:19 -0500]:
> > > > 
> > > > > On Friday 18 November 2005 13:29, Marc Koschewski wrote:
> > > > > > Nov 18 12:58:37 stiffy kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
> > > > > > 
> > > > > > SOME STUFF MISSING? HUH?
> > > > > > 
> > > > > > Nov 18 13:03:14 stiffy kernel: psmouse.c: resync failed, issuing reconnect request
> > > > > > 
> > > > > 
> > > > > Hm, this worries me a bit... Could you please try appying the patch
> > > > > below to plain 2.6.15-rc1 and see if mouse starts misbehaving again?
> > > > 
> > > > Dmitry,
> > > > 
> > > > I applied the 5 patches to a plain 2.6.15-rc1. The mouse was well as if it was
> > > > in an unpatched kernel. The problem just occured in 2.6.15-rc1-mmX.
> > > > Plain 2.6.15-rc1 was fine before as well. So: actually no change.
> > > > 
> > > > Need any more info?
> > > >
> > > 
> > > Marc,
> > > 
> > > Thank you for testing the patch. It proves that your mouse troubles
> > > were not caused by the patch I made so I am very happy. "No change"
> > > is the result I wanted to hear ;)
> > > 
> > 
> > Dmitry,
> > 
> > there's a bug report filed against Debian's udev. You can read it here:
> > 
> > 	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=340202
> > 
> > The bug report, however, states that the problem is caused by udev under
> > all variants of kernel 2.6.15. I'm writing this mail while running
> > 2.6.15-rc1 and the mouse definitely works. Do you have any other hint?
> > Seems to me like the bug report is only half the truth... 
> 
> Marc,
> 
> Are you, by some slim chance, manually loading mousedev ( via /etc/modules) or
> an init script?  If so your mouse will work.
> 

Hi Ed,

yes, I do load mousedev as well as psmouse in /etc/modules due to udev
no longer loading it. my problem, however, is _not_ that teh module
doesn't get loaded. It's the mouse pointer jumping all over the screen.
After some time (inactivity?) it calms down and is usable. Then, after
some minutes it again jumps wild all over the place, seems to click
stuff on it's own, and again calms down, ...

This problem shouldn't be udev related.

One note: the pointer seems to be in love with the corners of the
screen. It always goes there when it goes wild... ;)

Marc
