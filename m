Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290527AbSBFN6d>; Wed, 6 Feb 2002 08:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290536AbSBFN6X>; Wed, 6 Feb 2002 08:58:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26376 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290527AbSBFN6I>; Wed, 6 Feb 2002 08:58:08 -0500
Subject: Re: stumped with APM suspend/resume problem going from 2.4.5 ->
To: mjg23@yahoo.com (Matt)
Date: Wed, 6 Feb 2002 14:11:25 +0000 (GMT)
Cc: mikpe@csd.uu.se (Mikael Pettersson), linux-kernel@vger.kernel.org
In-Reply-To: <1012959556.1117.7.camel@blackbird.sectionone> from "Matt" at Feb 05, 2002 08:39:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YSnF-0005DM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> disabling both CONFIG_SMP and CONFIG_X86_UP_APIC fixed the
> suspend/resume problem.  I haven't confirmed whether or not
> CONFIG_X86_UP_APIC alone brings back the problem -- will let you know.

On my thinkpad enabling CONFIG_SMP with or without UP_APIC breaks APM support
at the resume stage. When I did some digging its deadlocking against itself
somehow with the cli/sti calls in the apm resume code path. Remove those and
it works

I didn't have time to get to the bottom of the problem
