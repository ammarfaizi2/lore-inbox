Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUAKQ0M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 11:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbUAKQ0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 11:26:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.173]:36351 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261875AbUAKQ0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 11:26:09 -0500
Date: Sun, 11 Jan 2004 17:27:16 +0100 (CET)
From: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter@peterpall.de>
Reply-To: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter.koenigsmann@gmx.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Peter Berg Larsen <pebl@math.ku.dk>
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync
 loss (With Patch). (fwd)
Message-ID: <Pine.LNX.4.53.0401111652510.1271@calcula.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:6f0b4d165b4faec4675b8267e0f72da4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Strike! Helps.

No more warnings, no more bad clicks, and a *real* smooth movement.

Never thought, a touchpad can work *this* well... ;-)

Anyway, I still get those 4 lines  on leaving X, but don't know, if it is
an error of the kernel, anyway, and doesn't do anything bad exept of
warning me:

atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).


Yours,

	Gunter.

-- 
Nasrudin called at a large house to collect for charity.  The servant said
"My master is out."  Nasrudin replied, "Tell your master that next time he
goes out, he should not leave his face at the window.  Someone might steal it."

---------- Forwarded message ----------
From: Dmitry Torokhov <dtor_core@ameritech.net>
Date: Sun, 11 Jan 2004 10:34:54 -0500
To: Gunter Königsmann <gunter.koenigsmann@gmx.de>
Delivered-To: GMX delivery to gunter.koenigsmann@gmx.de
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
     Peter Berg Larsen <pebl@math.ku.dk>
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync
    loss (With Patch).

On Sunday 11 January 2004 09:22 am, Vojtech Pavlik wrote:
> On Sun, Jan 11, 2004 at 01:52:46PM +0100, Peter Berg Larsen wrote:
> > On Sun, 11 Jan 2004, Gunter Königsmann wrote:
> > > Hmmm... Now I get an "Reverted to legacy aux mode" after about
> > > every third resync of the driver, and sometimes odd and sometimes
> > > even numbers of sync losses...
> >
> > How often is that? X/minute. I do not expect many "reverted .."
> > messages, but if there is, then I believe the mux ver 1.1 has added
> > some extra error codes that we se as a revert.
>
> Or the BIOS powermanagement is touching the controller in a way the MUX
> mode doesn't like ...

Does booting with i8042.i8042_nomux=1 help? That should keep the MUX in
legacy mode. (well, depending on the kernel version it's either i8042.nomux
or i8042.i8042_nomux, -mm1 and my patches use former, in 2.6.1 vanilla uses
later form).

Dmitry

