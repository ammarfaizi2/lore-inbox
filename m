Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbVKRLk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbVKRLk5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 06:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbVKRLk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 06:40:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63653 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161030AbVKRLk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 06:40:56 -0500
Date: Fri, 18 Nov 2005 12:40:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: dtor_core@ameritech.net
Cc: Bj?rn Mork <bmork@dod.no>, linux-kernel@vger.kernel.org
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Message-ID: <20051118114032.GD15825@elf.ucw.cz>
References: <87zmoa0yv5.fsf@obelix.mork.no> <d120d5000511171357g4d7a8d54hcc1c1d1cffa8856e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000511171357g4d7a8d54hcc1c1d1cffa8856e@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > IPv6 over IPv4 tunneling driver
> > NET: Registered protocol family 17
> > Using IPI Shortcut mode
> > Stopping tasks: ===<6>Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6ab1, caps: 0x884793/0x0
> > serio: Synaptics pass-through port at isa0060/serio1/input0
> > input: SynPS/2 Synaptics TouchPad as /class/input/input1
> >
> >  stopping tasks failed (1 tasks remaining)
> > Restarting tasks...<6> Strange, kseriod not stopped
> >  done
> 
> Crazy idea - did you let it finish booting or you hit suspend as soon
> as you could? It looks like kseriod was busy discovering your
> touchpad/trackpoint for the first time...
> 
> Anyway, Pavel, I think 6 seconds it too short of a timeout for
> stopping all tasks. PS/2 is pretty slow, trackpad reset can take up to
> 2 seconds alone...
> 
> Bjorn, does it help if you change TIMEOUT in kernel/power/process.c to 30 * HZ?

Funny, I thought that 6 seconds is way too much. Bjorn, please let us
know if 30 seconds timeout helps.
								Pavel
-- 
Thanks, Sharp!
