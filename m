Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263474AbTCNUSN>; Fri, 14 Mar 2003 15:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263476AbTCNUSN>; Fri, 14 Mar 2003 15:18:13 -0500
Received: from h-64-105-35-119.SNVACAID.covad.net ([64.105.35.119]:8328 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S263474AbTCNUSM>; Fri, 14 Mar 2003 15:18:12 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 14 Mar 2003 12:28:47 -0800
Message-Id: <200303142028.MAA02437@adam.yggdrasil.com>
To: EdV@macrolink.com
Subject: RE: devfs + PCI serial card = no extra serial ports
Cc: driver@jpl.nasa.gov, dwmw2@infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003 at 11:49:54, Ed Vance wrote:
>The largest gotcha that I am aware of for the PCI/setserial command 
>combination is the inability to automatically "follow" the card when 
>its address changes due to adding or removing an unrelated PCI device. 
>Even so, the system is unlikely to crash because the driver checks the 
>LSR register for impossible values and cuts off access when the UART 
>is not present.

	I would expect that setserial should only be used in cases
where this information is not reliably determinable by the kernel
through hardware device ID facilities, such as what we have in PCI,
USB, etc.  If that is not already the case, it should be
straightforward to fix in the kernel sources, which seemed to be most
of what the "3 Serial issues up for discussion" thread was about
(thanks for the pointer).  There was tangential mention in that thread
of a "/proc/serialdev" interface, but nobody really identified any
real benefit to it over the existing "uart: unknown" system.

	Anyhow, my primary point in this discussion is just to say
that, as far as I can tell, devfs does not impede the serial driver
from doing what Ted Ts'o seemed to be describing.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

