Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271380AbTG2Khz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 06:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271383AbTG2Khz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 06:37:55 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:17852 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S271380AbTG2Khy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 06:37:54 -0400
Date: Tue, 29 Jul 2003 12:37:33 +0200 (MEST)
Message-Id: <200307291037.h6TAbX9G026932@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de, vherva@niksula.hut.fi
Subject: Re: [PATCH] NMI watchdog documentation
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003 19:53:42 +0200, Andi Kleen wrote:
>On Wed, 23 Jul 2003 20:43:25 +0300
>Ville Herva <vherva@niksula.hut.fi> wrote:
>
>> Documentation/nmi-watchdoc.txt doesn't actually tell what options need to be
>> enabled in kernel config in order to use NMI watchdog. I for one found it
>> confusing.
>> 
>> I vaguely recall someone posted a similar patch some time ago, but it still
>> doesn't seem to be present in 2.4 or 2.6-test.
>> 
>> Andi: what about x86-64 - does it have something similar that should be
>> mentioned?
>
>x86-64 is the same, except APIC is always compiled in and the nmi watchdog is
>always enabled with perfctr mode. mode=2 seems to also not work correctly currently.
>
>However one caveat (even for i386): when you use perfctr mode 1 you lose the first
>performance register which you may need for other things.

Andi, you have the numbers mixed up. mode 1 is I/O-APIC, mode 2 is local APIC,
and x86-64 defaults nmi_watchdog to I/O-APIC mode.
Now, is it the I/O-APIC or local APIC watchdog that doesn't work in x86-64?

/Mikael
