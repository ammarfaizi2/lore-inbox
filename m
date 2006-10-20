Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946844AbWJTCmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946844AbWJTCmR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 22:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946847AbWJTCmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 22:42:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19619 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946844AbWJTCmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 22:42:16 -0400
Date: Thu, 19 Oct 2006 19:41:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: teunis <teunis@wintersgift.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: various laptop nagles - any suggestions?   (note:
 2.6.19-rc2-mm1 but applies to multiple kernels)
Message-Id: <20061019194157.1ed094b9.akpm@osdl.org>
In-Reply-To: <4537A25D.6070205@wintersgift.com>
References: <4537A25D.6070205@wintersgift.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 09:05:49 -0700
teunis <teunis@wintersgift.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Setting the internal clock to 100 Hz stablizes the laptop - and the
> synaptics touchpad stops "crashing"  (when "crashed" the pad reads out
> all kinds of seemingly random values).   I would suspect the driver
> needs adjusting for the variable clock.   Also - it's definitely nicer
> on the laptop power use as far as I can tell - should this be in the
> documentation?

So you're saying that CONFIG_NO_HZ breaks the touchpad?

> I'm very grateful that compact flash-based booting on a SATA system
> works well.   It hasn't been so reliable in 2.6.19-rc2-mm1 for IDE/CF
> adaptors but I haven't yet solved why.   (tested with various laptops)

hm.  What goes wrong?

> resume from "suspend to ram" (ACPI S3 mode) - the keyboard and mouse do
> not recover on 945G chipset.   Note that otherwise the chipset works
> well in 2.6.19-rc2-mm1 - and this is the first kernel that does work well).

So this might not be a new bug?

> LVM2 - when adding and removing physical volumes (again, on Compact
> Flash cards via USB and Firewire adaptors) - it doesn't always remove
> the volume properly (pvremove /dev/sda or equiv) from the device-mapper.
>  This leaves me unable to plug in another.   I suspect this to be an
> LVM2 problem (no hotplug?) rather than a compact flash or SCSI problem.

Can you identify an earlier kernel in which this worked OK?

