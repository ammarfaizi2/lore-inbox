Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSKHUXl>; Fri, 8 Nov 2002 15:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262344AbSKHUXk>; Fri, 8 Nov 2002 15:23:40 -0500
Received: from modemcable191.130-200-24.mtl.mc.videotron.ca ([24.200.130.191]:38411
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261894AbSKHUXh>; Fri, 8 Nov 2002 15:23:37 -0500
Date: Fri, 8 Nov 2002 15:30:02 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
cc: "'Corey Minyard'" <cminyard@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: RE: NMI handling rework
In-Reply-To: <A9713061F01AD411B0F700D0B746CA6802FC1544@vacho6misge.cho.ge.com>
Message-ID: <Pine.LNX.4.44.0211081524430.10231-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2002, Heater, Daniel (IndSys, GEFanuc, VMIC) wrote:

> Am I reading this correctly? As long as no one passes back NOTIFY_STOP_MASK,
> all handlers are run. Assuming that all external NMI sources have a means of
> checking whether they were the source, this would work like shared PCI
> interrupts.

On Linux we run through all handlers for shared interrupts, it is up to 
the handler to figure out wether it really was supposed to receive that 
interrupt (normally quick status checks for hardware).

> affected handlers have not run yet and will get run on the current pass, or
> they will run on the next pass. You may have two handlers run on a single
> pass but you should not drop any. True??

For sanity's sake stick to running through all of them, there should be no 
partial handling, every registered handler should get serviced once per 
NMI interrupt.

	Zwane
-- 
function.linuxpower.ca

