Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290895AbSASBJj>; Fri, 18 Jan 2002 20:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290897AbSASBJ3>; Fri, 18 Jan 2002 20:09:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30476 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290895AbSASBJL>; Fri, 18 Jan 2002 20:09:11 -0500
Subject: Re: [RFC] Summit interrupt routing patches
To: jamesclv@us.ibm.com
Date: Sat, 19 Jan 2002 01:18:09 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200201190018.g0J0Idq11657@butler1.beaverton.ibm.com> from "James Cleverdon" at Jan 18, 2002 04:18:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Rk93-0008SU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> idle CPUs.  If none are idle, then aim them at the CPUs running the "least 
> important" tasks.  Also, since each CPU's local APIC only has two interrupt 
> latches per `level' (the upper nibble of the IRQ's vector), it would be a 
> good idea to avoid sending IRQs to those CPUs that are already processing one.

Im not sure aiming at least important is worth anything. Aiming at idle 
processors on a box not doing power management seems easy providing you'll
accept 99.99% accuracy. Switch the priority up in the idle code, switch it
back down again before the idle task schedule()'s. If you hit during the
schedule well tough.

> soon.  I wonder if Marcelo is going to allow this kind of futzing around with 
> interrupt and scheduler code in 2.4....

Thats another reason to keep it small and clean.
