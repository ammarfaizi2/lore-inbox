Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129309AbRCBQgE>; Fri, 2 Mar 2001 11:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129310AbRCBQfy>; Fri, 2 Mar 2001 11:35:54 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18950 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129309AbRCBQfp>; Fri, 2 Mar 2001 11:35:45 -0500
Subject: Re: Linux 2.4.2ac7
To: tigran@veritas.com (Tigran Aivazian)
Date: Fri, 2 Mar 2001 16:38:48 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0103021605370.6279-100000@penguin.homenet> from "Tigran Aivazian" at Mar 02, 2001 04:11:51 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14YsZu-0001t3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I extend 'bus' to be 4 bits instead of 2 then I can make it work on all
> of my machines (or all those I tried), of course, extending the buscode[]
> table appropriately.

That would be interesting to see. Certainly the mul code got extended by a bit
later on

> However, the radically broken, imho, thing is that the (bus, mul) pair is
> _not_ constant when I vary the bus/cpu speed settings in the "soft cpu
> BIOS". If the bits of the 0x2A msr are supposed to be used for finding out
> the "true" i.e. intended bus/cpu speeds (hence the label "overclocked" in
> the code) then they should remain constant when one is overclocking,
> right?

The values are read from the poweron register. The values in that can be wrong
in certain cases. The real goal is to get the bus/multiplier values  for the
processors on an SMP box reliably. In fact the 'overclocked' hack is probably
not something I'd feed to Linus

Ultimately we need this to detect SMP boxes where the cpus have different
multipliers, as we must disable the TSC in these cases.

Alan

