Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273336AbTG3TYu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273355AbTG3TYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:24:50 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:56761 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S273336AbTG3TUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:20:38 -0400
Date: Wed, 30 Jul 2003 21:20:33 +0200 (MEST)
Message-Id: <200307301920.h6UJKXwC020610@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de, vherva@niksula.hut.fi
Subject: Re: [PATCH] NMI watchdog documentation
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003 20:53:19 +0300, Ville Herva wrote:
>On Tue, Jul 29, 2003 at 06:06:30PM +0200, you [Andi Kleen] wrote:
>> > Andi, you have the numbers mixed up. mode 1 is I/O-APIC, mode 2 is local APIC,
>> > and x86-64 defaults nmi_watchdog to I/O-APIC mode.
>> > Now, is it the I/O-APIC or local APIC watchdog that doesn't work in x86-64?
>> 
>> Right, 1 and 2 need to be exchanged. Anyways local apic mode does not seem
>> to work, the kernel always reportss "NMI stuck" at bootup.
>> IO APIC mode for is default.
...
>+For x86-64, the needed APIC is always compiled in, and the NMI watchdog is
>+always enabled with perfctr mode. Currently, mode=1 does not work on x86-64.

Didn't Andi just say it's the other way around? nmi_watchdog=1 (I/O-APIC)
by default since nmi_watchdog=2 (local APIC) doesn't work.

/Mikael
