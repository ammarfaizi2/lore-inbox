Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVBAFOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVBAFOi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 00:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVBAFOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 00:14:38 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:63148 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261548AbVBAFOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 00:14:31 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Touchpad problems with 2.6.11-rc2
Date: Tue, 1 Feb 2005 00:14:28 -0500
User-Agent: KMail/1.7.2
Cc: Peter Osterlund <petero2@telia.com>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
References: <20050123190109.3d082021@localhost.localdomain> <200501312240.35776.dtor_core@ameritech.net> <20050131210635.3c582934@localhost.localdomain>
In-Reply-To: <20050131210635.3c582934@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502010014.29326.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 February 2005 00:06, Pete Zaitcev wrote:
> On Mon, 31 Jan 2005 22:40:35 -0500, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> 
> > > Suddenly, touchpad motions started to cause wild movements in it became
> > > impossible to do anything due to a focus loss (of course, I had plenty of
> > > modified files open :-)
> 
> > > psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 3
> > > psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.
> > > psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 3
> > > psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> > > psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> > > psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.
> 
> > 1. Have you tried using external PS/2 mouse?
> > 2. Have you plugged/unplugged into a port replicator?
> 
> I have Dell Latitude D600, which does not have an external PS/2 port.
> 
> But actually, I was caught away from home, working from a library, so I did
> not have either PS/2 or USB mouse. I moved the cursor persistently for a
> few minutes until I managed to raise a window in such way that it got the
> focus, then I saved all files and closed all windows from the keyboard,
> so no harm done, no problem.
> 
> The kernel was running without resetafter set, unfortunately.
> 
> If you have a patch which prints offending data from pktbuffer, I can
> run that next time.
> 

No I don't but by the looks of it (constant stream of bad data) it looks
like somehow the touhcpad was reset back into PS/2 compatibility mode.
resetafter would catch it and reinitialize touchpad restoring proper
protocol.

-- 
Dmitry
