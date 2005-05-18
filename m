Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVERLS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVERLS4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 07:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVERLQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 07:16:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53720 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262210AbVERLOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 07:14:46 -0400
Date: Wed, 18 May 2005 13:13:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Kris Karas <ktk@enterprise.bidmc.harvard.edu>,
       linux-kernel@vger.kernel.org, Greg Stark <gsstark@mit.edu>
Subject: Re: Problem report: 2.6.12-rc4 ps2 keyboard being misdetected as /dev/input/mouse0
Message-ID: <20050518111322.GC1952@elf.ucw.cz>
References: <87zmuveoty.fsf@stark.xeocode.com> <200505160036.30628.dtor_core@ameritech.net> <4289682B.8060403@enterprise.bidmc.harvard.edu> <200505162358.15099.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505162358.15099.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >>I just updated to 2.6.12-rc4 and now /dev/input/mouse0 seems to be my ps2
> > >>keyboard.
> > >>
> > >Please use /dev/input/mice for accessing your mouse.
> > >
> > 
> > One possibly interesting mouse issue in 2.6.12-rc[1..4] is that when 
> > using /dev/psaux, I have found that my mouse cursor under GPM seems to 
> > be triggered into un-hiding when I issue some random number of 
> > non-hiding key-down events.  That is, press and release the keyboard 
> > shift key say 3 or 5 or 10 times, and the console mouse cursor will 
> > appear, just as if the mouse had been moved.  This bug is not in 2.6.11 
> > (nor Alan's 2.6.11-ac7, fwiw).
> > 
> 
> This is caused by atkbd's scrolling support + GPM not expecting to see a
> 0-motion packets from devices... I'd say we need to fix GPM not to set
> GPM_MOVE in these cases; I have looked into adjusting mousedev but it is
> too ugly for words to suppress them there.
> 
> Although... maybe the patch below is not too ugly.

Looks pretty much okay to me...
								Pavel
