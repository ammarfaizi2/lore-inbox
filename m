Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261819AbRESPNh>; Sat, 19 May 2001 11:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261824AbRESPNR>; Sat, 19 May 2001 11:13:17 -0400
Received: from adsl-151-196-235-14.baltmd.adsl.bellatlantic.net ([151.196.235.14]:13298
	"EHLO vaio.greennet") by vger.kernel.org with ESMTP
	id <S261819AbRESPNH>; Sat, 19 May 2001 11:13:07 -0400
Date: Sat, 19 May 2001 11:15:38 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-net@vger.rutgers.edu, jgarzik@mandrakesoft.com
Subject: Re: RTL8139 difficulties in 2.2, not in 2.4
In-Reply-To: <20010519140413.B1795@emma1.emma.line.org>
Message-ID: <Pine.LNX.4.10.10105191107450.956-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 May 2001, Matthias Andree wrote:

> I'm having difficulties with a RTL8139 with Linux 2.2.19 (both drivers),
> but not with Linux 2.4.4's 8139too driver. The card is an Allied Telesyn
> AT-2500TX, the chip is reported as 8139C/rev. 0x10. The card shares its
> IRQ 9 with an nVidia Riva TNT 128 [NV04], rev. 4.
...
> eth1: Transmit timeout, status 0c 0005 media 18.
> eth1: Tx queue start entry 4  dirty entry 0.
> eth1: RTL8139 Interrupt line blocked, status 5.
> eth1: RTL8139 Interrupt line blocked, status 5.
> eth1: RTL8139 Interrupt line blocked, status 4.
> eth1: RTL8139 Interrupt line blocked, status 4.
> (continues every minute with status 4 if no traffic on interface)

The card is reporting that the interrupt line has been asserted (Tx
done), but the interrupt handler hasn't been called.

You can verify this by watching the interrupt count in /proc/interrupts.

Try booting the kernel with "noapic", which we recommend as the safe
default setting.


Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

