Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265814AbUFXQLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265814AbUFXQLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 12:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUFXQLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 12:11:15 -0400
Received: from web81301.mail.yahoo.com ([206.190.37.76]:45915 "HELO
	web81301.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265814AbUFXQLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 12:11:13 -0400
Message-ID: <20040624161113.92578.qmail@web81301.mail.yahoo.com>
Date: Thu, 24 Jun 2004 09:11:13 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: RE: Continue: psmouse.c - synaptics touchpad driver sync problem
To: Marc Waeckerlin <marc.waeckerlin@siemens.com>
Cc: t.hirsch@web.de, laflipas@telefonica.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Am Mittwoch, 23. Juni 2004 17.59 schrieb Dmitry Torokhov unter "RE:
> Continue:
> psmouse.c - synaptics touchpad driver sync problem":
> > Also, if you have time, please change #undef DEBUG to #define DEBUG in
> > drivers/input/serio/i8042.c, reboot, play a bit with touchpad; plug
> > external keyboard and send me output of "dmesg -s 100000".
> 
> dmesg looks like this, even with a log_buf_len=131072 boot-parameter,
> there's
> nothiung else left. These are the interesting parts:
> 
> [dmesg starts here, this is first line]
> erio/i8042.c: 80 <- i8042 (interrupt, aux1, 12) [158589]
<skip>

> All the other lines look similar to:
> drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158654]
> 
> There is no more left from the boot process. That means, the trace is so
> frequent, that it overflows long before I can get the dmesg. I also tried
> with 33554432 Bytes, but there seem to be a size limit?
> 
> I don't think it makes sense to attach the full trace (>100kB), I don't
> want
> to send too large messages, what do you think?

You still need to use "dmesg -s 100000" even if you specifie logbuf_len.
Anyway, the data probably goes into /var/log/messages as well... If it is
there please send it my way (not on the list). I should be able to handle
100K e-mail.

Thanks,

Dmitry 
