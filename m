Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWE3NuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWE3NuV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 09:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWE3NuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 09:50:21 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:57280 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751503AbWE3NuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 09:50:20 -0400
Date: Tue, 30 May 2006 15:50:18 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Keith Chew <keith.chew@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO APIC IRQ assignment
Message-ID: <20060530135017.GD5151@harddisk-recovery.com>
References: <20f65d530605300521q1d56c3a3t84be3d92f1df0c14@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20f65d530605300521q1d56c3a3t84be3d92f1df0c14@mail.gmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 12:21:53AM +1200, Keith Chew wrote:
> We are working closely with an x86-based hardware manufacturer for our
> linux based application. In their hardware, it contains 4 x BT878
> chips and 3 x USB controllers.

That sounds like a nice MythTV box to me :)

> The USB and BT878 share the same
> hardware IRQ lines, which is causing us to notice random hard lockups.
> Increasing the PCI latency of the BTTV drivers has helped the
> situation (we have not noticed any lockups yet), but it would be nice
> if we can separate the IRQs.
> 
> We asked the manufacturers if they can do a physical modication for
> us, but unfortunately this is not possible. The engineer did mention
> that under Windows XP in "IO APIC" mode, it is possible to assign
> different IRQs to the USB and BTTV.

Unless Windows XP IO APIC mode contains a soldering iron and rework
wire to physically change the way the hardware IRQ lines are connected,
this is nonsense.

Or the engineer means that in legacy PIC mode the IRQs are shared, but
in APIC mode they can be separated. That is a different thing, cause in
that case the IRQ lines are not physically connected, but put together
in PIC mode and can again be separated by using APIC mode.

> Is this possible in Linux? We have tried enabling IO APIC in the
> kernel, but the IRQs are still shared.

Depends on the hardware, but Linux does indeed support IO APIC.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
