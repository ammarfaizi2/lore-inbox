Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268100AbTBMR41>; Thu, 13 Feb 2003 12:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268101AbTBMR41>; Thu, 13 Feb 2003 12:56:27 -0500
Received: from kim.it.uu.se ([130.238.12.178]:22408 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S268100AbTBMR41>;
	Thu, 13 Feb 2003 12:56:27 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15947.56983.116325.910540@kim.it.uu.se>
Date: Thu, 13 Feb 2003 19:06:15 +0100
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>
Subject: Re: 2.5.60 - Strange APIC errors
In-Reply-To: <20030213173315.B629@nightmaster.csn.tu-chemnitz.de>
References: <20030213173315.B629@nightmaster.csn.tu-chemnitz.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser writes:
 > I'm running 2.5.60 and get a strange APIC error (dmesg appended).
 > These errors don't stop, so I tried to limit them with that
 > simple code below in arch/i386/kernel/apic.c to get the first
 > offender and to get sth. else as printk() done. It seems, that
 > somehow value 0x40 gets written there, which is not documented.

 > APIC error on CPU1: 00(40)

0x40 == Received illegal vector

 > APIC error on CPU1: 40(08)

0x08 == Receive accept error

They _are_ documented, in smp_error_interrupt() and Intel's IA32 Volume 3.
