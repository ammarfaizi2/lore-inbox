Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVGGUGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVGGUGS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 16:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVGGUEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 16:04:04 -0400
Received: from web81308.mail.yahoo.com ([206.190.37.83]:43953 "HELO
	web81308.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262305AbVGGUCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 16:02:39 -0400
Message-ID: <20050707200238.52898.qmail@web81308.mail.yahoo.com>
Date: Thu, 7 Jul 2005 13:02:38 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Synaptics Touchpad not detected in 2.6.13-rc2
To: Mattia Dongili <malattia@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: vojtech@suse.cz, Dmitry Torokhov <dtor@mail.ru>
In-Reply-To: <20050707193027.GA4162@inferi.kami.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattia Dongili <malattia@gmail.com> wrote:
> Hello,
> 
> with -rc2 (-rc1 didn't show this behaviour) I get the following when
> modprobing psmouse.ko:
> 
> atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86,
> might be trying access hardware directly.
> 
> and the touchpad is not detected at all.
> 
> The ps2_adjust_timeout function seems to be the cause, restoring the old
> fixed timeout in ps2_command seems to cure this issue (see diff below).
> It could be probably done better by detecting which command misses the
> the last bytes and recalibrating ps2_adjust_timeout instead. Or maybe
> checking the return value of wait_event_timeout for a next round of
> wait?
> 
> This is the device (on a Vaio GR), which other info could I provide to
> better diagnose the problem?
> 

Could you please do "echo 1 > /sys/modules/i8042/parameters/debug";
reload psmouse module and send me dmesg please?

Thanks!

-- 
Dmitry

