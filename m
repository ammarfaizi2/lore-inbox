Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUHBROD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUHBROD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 13:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266655AbUHBROD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 13:14:03 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:37586 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S266674AbUHBRNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 13:13:32 -0400
Date: Mon, 2 Aug 2004 19:13:25 +0200
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [linux-usb-devel] 2.6.8-rc2-mm2 with usb and input problems
Message-ID: <20040802171325.GA26949@gamma.logic.tuwien.ac.at>
References: <20040802162845.GA24725@gamma.logic.tuwien.ac.at> <200408021003.42090.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200408021003.42090.david-b@pacbell.net>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David!
On Mon, 02 Aug 2004, David Brownell wrote:
> > - USB deadlocking
> >   USB is still deadlocky, quite often process hang in D+ state.
> 
> So what does alt-sysrq-t show you about those processes?

Ok, I will write it down next time ;-) It happens during the boot
process, but I will try to get it happen after login by starting hotplug
by hand.

> How do you reproduce these hangs?  I'm guesssing that
> And does 2.6.8-rc (without the MM patch) acts the same.

Hmm, haven't tested this yet, always running -mm kernels.

> > - psmouse/synaptics
> >   If I have usb as module, I cannot get synaptics to be recognized.
> 
> Odd.  BIOS settings maybe?

No, definitely not. I think it only depends on the modules loaded, and
if usb is modular then input is loaded after psmouse/mousedev and this I
cannot reverse, because I cannot get mousedev/psaux to be build modular.

> The S2R issue is caused by delivering bogus PCI
> device power states to PCI drivers.  See if the patch
> in http://bugme.osdl.org/show_bug.cgi?id=2886
> helps at all.  (It might be better to map STANDBY

Will try this. Thanks.

> If you don't actually have code trying to suspend
> USB devices, don't enable it.  Until some other

Ok.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
LOWTHER (vb.)
(Of a large group of people who have been to the cinema together.) To
stand aimlessly about on the pavement and argue about whatever to go
and eat either a Chinese meal nearby or an Indian meal at a restaurant
which somebody says is very good but isn't certain where it is, or
have a drink and think about it, or just go home, or have a Chinese
meal nearby - until by the time agreement is reached everything is
shut.
			--- Douglas Adams, The Meaning of Liff
