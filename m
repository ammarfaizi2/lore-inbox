Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbTJLLvT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 07:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263454AbTJLLvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 07:51:18 -0400
Received: from gprs145-73.eurotel.cz ([160.218.145.73]:3968 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263453AbTJLLvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 07:51:12 -0400
Date: Sun, 12 Oct 2003 13:50:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Norman Diamond <ndiamond@wta.att.ne.jp>, Patrick Mochel <mochel@osdl.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6 APM/IDE double-suspend weirdness
Message-ID: <20031012115057.GB378@elf.ucw.cz>
References: <2c8a01c390a2$cee80640$5cee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c8a01c390a2$cee80640$5cee4ca5@DIAMONDLX60>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[Disk is going up/down/up/down when doing apm -s].

> >  > Try removing pm_send_all from apm.c
> >
> > Ok I tried removing all pm_send_all from apm.c.
> > I made no difference at all.
> 
> I am not surprised.  2.4.20 has the same pm_send_all but does not
> >have

Well, 2.4.20 does not have driver model, either.

> What is the intended effect of device_suspend(3)?  Am I asking for trouble
> by removing it?

Notebook bios is expected to handle apm -s itself. But most notebooks
get it wrong (and fail to save state of audio or something),
device_suspend() should help that. If it works without that, thats
fine.

Try doing without syslogd.

apm really should stop all processes before going to driver model, or
spinup/spindown/spinup weirdness is well possible. Anyway, this is
driver model, Patrick should know more.
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
