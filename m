Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbVKXElY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbVKXElY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 23:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVKXElY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 23:41:24 -0500
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:50063 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751337AbVKXElX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 23:41:23 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Ed Tomlinson <tomlins@cam.org>
Subject: Re: psmouse unusable in -mm series (was: 2.6.15-rc1-mm2 unsusable on DELL Inspiron 8200, 2.6.15-rc1 works fine)
Date: Wed, 23 Nov 2005 23:41:18 -0500
User-Agent: KMail/1.8.3
Cc: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org,
       340202@bugs.debian.org
References: <20051118182910.GJ6640@stiffy.osknowledge.org> <20051123195700.GB7446@stiffy.osknowledge.org> <200511232129.35796.tomlins@cam.org>
In-Reply-To: <200511232129.35796.tomlins@cam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511232341.19027.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 November 2005 21:29, Ed Tomlinson wrote:
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

The only change in input between 2.6.15-rc1 and 2.6.15-rc-mm2 is that
psmouse resync patch. Marc, is you revert psmouse resync patch from -mm
does the mouzse still misbehaves?

-- 
Dmitry
