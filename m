Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTGCMZc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 08:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTGCMZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 08:25:31 -0400
Received: from mailg.telia.com ([194.22.194.26]:29928 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id S261265AbTGCMZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 08:25:21 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: bert hubert <ahu@ds9a.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Synaptics trouble in 2.5.73
References: <20030702185412.GA24350@outpost.ds9a.nl>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Jul 2003 12:42:00 +0200
In-Reply-To: <20030702185412.GA24350@outpost.ds9a.nl>
Message-ID: <m2fzlnzybr.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert <ahu@ds9a.nl> writes:

> Up to 2.5.68 my laptop had no problems with its touchpad but since upgrading
> to 2.5.73, neither gpm nor X see my mouse anymore. 
> 
> >From dmesg:
> 
> Jul  2 20:17:38 snapcount kernel: mice: PS/2 mouse device common for all mice
> Jul  2 20:17:38 snapcount kernel: inport.c: Didn't find InPort mouse at 0x23c
> Jul  2 20:17:38 snapcount kernel: logibm.c: Didn't find Logitech busmouse at 0x23c
> Jul  2 20:17:38 snapcount kernel: pc110pad: I/O area 0x15e0-0x15e4 in use.
> Jul  2 20:17:38 snapcount kernel: input: PC Speaker
> Jul  2 20:17:38 snapcount kernel: i8042.c: Detected active multiplexing controller, rev 1.0.
> Jul  2 20:17:38 snapcount kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
> Jul  2 20:17:38 snapcount kernel: Synaptics Touchpad, model: 1
> Jul  2 20:17:38 snapcount kernel:  Firware: 4.1
> Jul  2 20:17:38 snapcount kernel:  Sensor: 8
> Jul  2 20:17:38 snapcount kernel:  new absolute packet format
> Jul  2 20:17:38 snapcount kernel: input: Synaptics Synaptics TouchPad on isa0060/serio2
> 
> Later on, I get this:
> Synaptics driver lost sync at 1st byte
> Synaptics driver lost sync at 4th byte
> Synaptics driver resynced.
> 
> But the mouse still does not work. This is a 'Gericom' laptop, which
> contains mostly SiS parts. Anything I can do to help debug this, just let me
> know.

There have been some reports on the list concerning SiS and keyboard
oddities. (Missing key release events causing endless autorepeat for
example.) Maybe this problem is somehow related.

> I saw mention of special X drivers for this, but the kernel messages appear
> to indicate that the kernel itself is not succeeding in communicating with
> the touchpad.

The kernel messages could very well indicate that the communication
works 99.9% of the time, but you really need the special X driver or
else the touchpad will not work at all in X.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
