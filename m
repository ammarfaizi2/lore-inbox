Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272290AbTG3WxJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272300AbTG3WxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:53:09 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:63431 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S272290AbTG3WxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:53:05 -0400
Date: Thu, 31 Jul 2003 00:53:00 +0200 (MEST)
Message-Id: <200307302253.h6UMr0XW024175@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: vherva@niksula.hut.fi
Subject: Re: [PATCH] NMI watchdog documentation
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003 22:40:52 +0300, Ville Herva wrote:
>Ok, you got me confused (thankfully I didn't submit anything for inclusion
>yet. :)
...
>So... Should it be something like:
>
>+For x86-64, the needed APIC is always compiled in, and the NMI watchdog is
>+always enabled with perctr mode. Currently, mode=2 (local APIC) does not

always enabled with I/O-APIC mode.

>+work on x86-64. IO APIC mode (mode=1) is the default. Using NMI watchdog

Using local APIC

>+(mode=1) needs the first performance register, so you can't use it for

(mode=2)

>+other purposes (such as high precision performance profiling.)

>(Is the last sentence only valid for x86-64?)

No, it's true for both x86 and x86-64. However, both oprofile
and the perfctr driver disable the local APIC NMI watchdog, so
the statement is only true for other drivers that don't do this.

/Mikael
