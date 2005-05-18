Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVERLPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVERLPD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 07:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbVERLOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 07:14:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52184 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262203AbVERLOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 07:14:05 -0400
Date: Wed, 18 May 2005 13:12:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Greg Stark <gsstark@mit.edu>,
       vojtech@suse.cz
Subject: Re: Problem report: 2.6.12-rc4 ps2 keyboard being misdetected as /dev/input/mouse0
Message-ID: <20050518111207.GB1952@elf.ucw.cz>
References: <87zmuveoty.fsf@stark.xeocode.com> <200505160036.30628.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505160036.30628.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I just updated to 2.6.12-rc4 and now /dev/input/mouse0 seems to be my ps2
> > keyboard. My ps2 mouse is now on /dev/input/mouse1.
> > 
> > 
> > Good thing to catch before you release 2.6.12 and get the usual swarm of "my
> > mouse stopped working" reports. It seems to be getting to be a pattern:
> > upgrade linux kernel -- debug why mouse stopped working.
> >
> 
> atkbd's scroll support was turned on by default causing mouse moved over a
> bit.
>  
> Please use /dev/input/mice for accessing your mouse. /dev/input/mouseX are
> not guaranteed to be stable, if you need stable names you'll have to adjust
> your hotplug scripts.

Please please, fix this one. It causes spurious events in /dev/psaux
when you type on keyboard. Events are nops (no movement, no clicks),
but they still wake up gpm (ugly) and make it show mouse cursor. So
you have second, blinking! cursor on your screen when you type.

								Pavel
