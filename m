Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317416AbSGXRZb>; Wed, 24 Jul 2002 13:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317422AbSGXRZb>; Wed, 24 Jul 2002 13:25:31 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:45004 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S317416AbSGXRZa>;
	Wed, 24 Jul 2002 13:25:30 -0400
Date: Wed, 24 Jul 2002 19:28:23 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200207241728.TAA28800@harpo.it.uu.se>
To: jamesclv@us.ibm.com, zwane@linuxpower.ca
Subject: Re: 2.4.19-rc3-ac2 SMP
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002 17:26:49 +0200 (SAST), Zwane Mwaikambo wrote:
>i'd vote for that =) except for one thing.
>
>+       /* APICs tend to spasm when they get errors.  Disable the error intr. */
>+       apic_write_around(APIC_LVTERR, ERROR_APIC_VECTOR | APIC_LVT_MASKED);
>
>Isn't that a bit drastic?

Drastic is an understatement. Try "gross". Sane machines running correct
code shouldn't throw local APIC errors. If something's causing errors,
that something should be fixed, not hidden.

I hope that was just a temporary debug hack and not part of the design...

/Mikael
