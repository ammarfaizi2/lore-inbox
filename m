Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbUL3RDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbUL3RDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 12:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbUL3RDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 12:03:51 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:28850 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261674AbUL3RDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 12:03:48 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, Andrew Haninger <ahaning@gmail.com>
Subject: Re: Fwd: Toshiba PS/2 touchpad on 2.6.X not working along bottom and right sides
Date: Thu, 30 Dec 2004 12:03:43 -0500
User-Agent: KMail/1.6.2
Cc: hps@intermeta.de
References: <105c793f04122907116b571ebf@mail.gmail.com> <cr16ho$eh1$1@tangens.hometree.net> <105c793f041230080734d71c4a@mail.gmail.com>
In-Reply-To: <105c793f041230080734d71c4a@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412301203.44484.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 December 2004 11:07 am, Andrew Haninger wrote:
> On Thu, 30 Dec 2004 15:23:36 +0000 (UTC), Henning P. Schmiedehausen
> <hps@intermeta.de> wrote:
> > This might be a touchpad that simulates the scroll wheel on the right
> > side and horizontal scrolling on the bottom.
> > 
> > Does your touchpad emit mouse button events when touching on the
> > right / bottom side?
> > 
> > I have a Toshiba Satellite with another touchpad (a Synaptics) and
> > this can be programmed to do so. I'd think that Toshiba noadays uses
> > touchpads that have this hard-coded (maybe there is a command to turn
> > this on/off).
> I have a ThinkPad T42 that can do this, as well, and this is what I
> thought when I first encountered this problem. However, I've had this
> Gateway laptop since about 1999 and it hasn't done this since. Not in
> 2.2 or 2.4.
> 
> Also, like I said, xev produced no output when I touched and dragged
> in the offending areas.
> 
> If this really is an added feature and there's a way to turn it off,
> that would be okay. Having it off by default would be best since it's
> seemingly a changed behavior between one kernel version and another
> (also, I hate that feature :) ).
> 

Yes, you can. Booting with psmouse.proto=bare will force the touchpad
into standard PS/2 mode. You may also try booting with
psmouse.proto=imps and psmouse.proto=exps - maybe one of these 2 will
give you virtual scrolling.

If psmouse is compiled as a module you will have to add

	options psmouse proto=bare

to your /etc/modprobe.conf

Btw, what device/protocol are you using in X? I'd advise setting it
to "dev/input/mice" and "ExplorerPS/2" so if your touchad is indeed
sending scroll events X would use them. Could you post your config,
please?

Thanks!

-- 
Dmitry
