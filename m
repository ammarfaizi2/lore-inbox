Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271051AbTGVXNk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 19:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271052AbTGVXNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 19:13:40 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:2517 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S271051AbTGVXNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 19:13:38 -0400
Date: Wed, 23 Jul 2003 01:28:24 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: APIC support prevents power off
Message-ID: <20030722232824.GA3606@k3.hellgate.ch>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	linux-kernel@vger.kernel.org, mingo@redhat.com
References: <200307220835.h6M8Zaqd024427@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307220835.h6M8Zaqd024427@harpo.it.uu.se>
X-Operating-System: Linux 2.5.75 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jul 2003 10:35:36 +0200, Mikael Pettersson wrote:
> You really should check if a BIOS update is available.

Alright. I tried. If the BIOS is at fault, ASUS hasn't fixed it yet.

> Your APM/ACPI config seems Ok, but what does CONFIG_SMP look like?
> Enabling SMP disables APM's power off code, unless one boots with
> apm=power-off.

SMP is off.

> Did your kernel have to actually enable the local APIC, or did
> the BIOS boot us with it already enabled? Please send me a dmesg

$ dmesg|grep APIC
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Using local APIC timer interrupts.
calibrating APIC timer ...

> I can't seem to find any place where we disable the local APIC
> on shutdown; reboot seems Ok but not poweroff (as far as I can see).
> I think this might explain why some BIOSen hang at poweroff.

Quite possibly.

Roger
