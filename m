Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267137AbTGGRSC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 13:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267139AbTGGRSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 13:18:02 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:6930 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267137AbTGGRSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 13:18:00 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Peter Berg Larsen <pebl@math.ku.dk>
Subject: Re: [PATCH] Synaptics: support for pass-through port (stick)
Date: Mon, 7 Jul 2003 12:34:02 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <Pine.LNX.4.40.0307071308310.28730-100000@shannon.math.ku.dk>
In-Reply-To: <Pine.LNX.4.40.0307071308310.28730-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307071234.02595.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 July 2003 06:44 am, Peter Berg Larsen wrote:
> On Sun, 6 Jul 2003, Dmitry Torokhov wrote:
> > +	/* adjust the touchpad to child's choice of protocol */
> > +	child = port->private;
> > +	if (child && child->type >= PSMOUSE_GENPS) {
>
> Not type > PSMOUSE_GENPS ?
>

We have this code in psmouse-base.c ...

        if (psmouse->pktcnt == 3 + (psmouse->type >= PSMOUSE_GENPS)) {
                psmouse_process_packet(psmouse, regs);
                psmouse->pktcnt = 0;
                goto out;
        }

..or am I misreading it?

I will check what can be done with 0xAA 0x00 before we decide to rescan 
later this evening.

Dmitry



