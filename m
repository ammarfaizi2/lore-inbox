Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTIPQfP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 12:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbTIPQfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 12:35:15 -0400
Received: from infres.enst.fr ([137.194.192.1]:12780 "EHLO infres.enst.fr")
	by vger.kernel.org with ESMTP id S261844AbTIPQfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 12:35:06 -0400
Date: Tue, 16 Sep 2003 18:35:04 +0200 (MEST)
From: Ramon Casellas <casellas@infres.enst.fr>
X-X-Sender: casellas@gervaise.enst.fr
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug/Oops Power Management with linux-2.6.0-test5-mm2
In-Reply-To: <Pine.LNX.4.33.0309160856390.958-100000@localhost.localdomain>
Message-ID: <Pine.SOL.4.40.0309161819150.7029-100000@gervaise.enst.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003, Patrick Mochel wrote:

>
> > echo -n mem > /sys/power/state
> >
> > PM: Preparing system for suspend
(...)
> > MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
> > Bank 1: e200000000000005
(...)
> >


>
> Excuse my confusion, but is the machine suspending or is it returning
> immediately to the command line?
>

When suspending to mem, actually it "looks like" it suspends. The only
thing is that the LCD stays "light grey" (yep, I know it is not a
technical description... :). In order to resume, I have to press the
thinkpad power button (tap it, if I hold it for several seconds, it just
powers off). When resuming, there must be a problem with interrumpts (NIC
and Trackpoint stop working). So, it is not "immediate"




> >
> > with
> > echo -n disk > /sys/power/state
> >
> > Stopping tasks: ===================================================================
> >  stopping tasks failed (1 tasks remaining)
> >  Restarting tasks...<6> Strange, artsd not stopped
> >   done
>
>

Suspend to disk does not work (If I don't kill artsd, cf. previous
message). If I kill artsd first, :
Stopping tasks:
================================================================
=======|
Freeing memory: .........................................................|
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Attempting to suspend to disk.
PM: snapshotting memory.
pmdisk is not supported with high- or discontig-mem.
PCI: Setting latency timer of device 0000:00:1f.5 to 64
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
hda: completing PM request, resume
Restarting tasks... done


(1 Gb RAM)

In both cases, when suspending to disk, it returns immediately.


Thanks,
R.






