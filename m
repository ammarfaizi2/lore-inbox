Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUF3P7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUF3P7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266732AbUF3P7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:59:23 -0400
Received: from web81307.mail.yahoo.com ([206.190.37.82]:2990 "HELO
	web81307.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266721AbUF3P7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:59:06 -0400
Message-ID: <20040630155904.2689.qmail@web81307.mail.yahoo.com>
Date: Wed, 30 Jun 2004 08:59:04 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: RE: 2.6.7 oops in psmouse/serio while booting
To: twl@mail.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,
> > Hi,
> >
> > Could you please try the patch below?
> >
> > --
> > Dmitry
> >
> 
> Dmitry,
> 
> Thanks for the quick response.  That fixed it.
> 
> FYI, I still get
> input: PS/2 XXX Mouse on isa0060/serio1
> I booted 10 times, and "XXX" was "Generic" 7 times and "Logitech" 3 times.

This is still bad, I would prefer your Logitech mouse be identified
as such every time. Could you please try changing #undef DEBUG to
#define DEBUG in drivers/input/serio/i8042.c nad sending me 2 dmesg
oputputs - one when the mouse identified as "Generic" and one where
it is identified as "Logitech" - maybe I will see somethng there.
You might need log_buf_size=131072 kernel option to capture entire
dmesg and use "dmesg -s 131072" to dump it.

You can send the logs directly to me to not litter the mailing list.
 
> But no more oops. :^)
This is good ;) Still it was somewhat a stop-gap measure - something
else is going on - it was not supposed to hit that place in the
code yet.

Thank you for testing my patch.

--
Dmitry
