Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVA2TIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVA2TIe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVA2TId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:08:33 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:57550 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261337AbVA2TIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:08:04 -0500
Date: Fri, 28 Jan 2005 20:35:42 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Wiktor <victorjan@poczta.onet.pl>, linux-kernel@vger.kernel.org
Subject: Re: AT keyboard dead on 2.6
Message-ID: <20050128193542.GA2877@ucw.cz>
References: <41F11F79.3070509@poczta.onet.pl> <d120d500050121074831087013@mail.gmail.com> <41F15307.4030009@poczta.onet.pl> <d120d500050121113867c82596@mail.gmail.com> <41F69FFE.2050808@poczta.onet.pl> <20050128143121.GB12137@ucw.cz> <d120d50005012806467cc5ee03@mail.gmail.com> <41FA90F8.6060302@poczta.onet.pl> <d120d5000501281127752561a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000501281127752561a3@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 02:27:20PM -0500, Dmitry Torokhov wrote:
> On Fri, 28 Jan 2005 20:22:32 +0100, Wiktor <victorjan@poczta.onet.pl> wrote:
> > Hi,
> > 
> > >This dmesg looks like the keyboard works perfectly OK. Do new lines
> > >appear in dmesg when you press keys while the system is running?
> > 
> > eeeeeeee.....no? no, they don't. i've new dmesg for you - it reports
> > timeouts while trying to perform keyboard reset (by atkbd.reset=1).
> > after detection pressing any keys has absolutley no effect. maybe it's
> > some timeout-violation?
> > 
> 
> Could you please try editing drivers/input/serio/i8042.c and add
> udelay(20) before and after calls to i8042_write_data() in
> i8042_kbd_write() and i8042_command().
 
Uh? What that'd help? All the communication proceeds OK, up to proper
registration of the input device, but the keyboard seems to stay in a
'disabled' state. The keyboard, not the controller, because if it were
the controller, atkbd.c wouldn't get the 'fa' responses back via
functioning interrupts.

Wiktor, can you try atkbd.dumbkbd=1?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
