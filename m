Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVA2TOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVA2TOw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVA2TND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:13:03 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:64718 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261546AbVA2TIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:08:18 -0500
Date: Fri, 28 Jan 2005 21:25:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Wiktor <victorjan@poczta.onet.pl>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: AT keyboard dead on 2.6
Message-ID: <20050128202532.GA10301@ucw.cz>
References: <41F15307.4030009@poczta.onet.pl> <d120d500050121113867c82596@mail.gmail.com> <41F69FFE.2050808@poczta.onet.pl> <20050128143121.GB12137@ucw.cz> <d120d50005012806467cc5ee03@mail.gmail.com> <41FA90F8.6060302@poczta.onet.pl> <d120d5000501281127752561a3@mail.gmail.com> <41FA972F.2000604@poczta.onet.pl> <d120d50005012811534eb1ed70@mail.gmail.com> <41FA9EFC.9040600@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FA9EFC.9040600@poczta.onet.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 09:22:20PM +0100, Wiktor wrote:
> Hi,
> 
> >We do test AUX port and your port appears to be perfectly functional
> >from the kernel point of view - it porperly responds to AUX_LOOP
> >commands, does not claim to support MUX mode and KBC properly sets
> >status register when asked to disable interface...
> 
> ok, but how AUX block KBD port? if procesor-interface works, it 
> shouldn't disturb communication in any way!

The AUX and KBD ports share the same processor interface. If the AUX
port is enabled, and somehow keeps the interface for itself, then the
keyboard wouldn't work.

For some reason, however, the keyboard is recognized, which means it
_can_ communicate with the kernel. I don't understand why it doesn't, at
the moment.

> how it is possible that 
> tests do not detect broken down port? 

The kernel issues the AUX_TEST command, which instructs the port
controller to test whether the port is OK. And the controller returns
with "Yes, it is."

> if kernel enables it in some way 
> (when disabling port from command line, KBD works ok), it should be 
> detected that AUX does not work correctly and lock it somehow? 

Remember, it's the keyboard that doesn't work in that case. How the
kernel should know the AUX port is the cause, and how it should discern
that from the user not typing?

> can it be 
> etermined by analyzing data flow? 

No.

> or maybe tests are not enought good, 
> maybe some corelations when using both KBD and AUX exist and are not 
> tested? as my keyboard works now, i'm not keen on solving this, but to 
> make the world better and dominate it, some "runtime hardware failures 
> handling" could be added.
 
We're pretty happy when it works on functional hardware at the moment.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
