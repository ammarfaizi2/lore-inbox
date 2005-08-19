Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932741AbVHSW7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741AbVHSW7q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 18:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932742AbVHSW7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 18:59:45 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:58057
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932741AbVHSW7p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 18:59:45 -0400
Subject: Re: 2.6.13-rc6-rt9
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Darren Hart <dvhltc@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, "lkml," <linux-kernel@vger.kernel.org>
In-Reply-To: <4306596D.1000403@us.ibm.com>
References: <20050818060126.GA13152@elte.hu>  <4306596D.1000403@us.ibm.com>
Content-Type: text/plain
Organization: linutronix
Date: Sat, 20 Aug 2005 01:00:02 +0200
Message-Id: <1124492403.23647.543.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-19 at 15:13 -0700, Darren Hart wrote:
> I was trying to use another HRT clock source and couldn't get menuconfig 
> to let me select acpi-pm-timer, turns out it has been disabled in 
> arch/i386/Kconfig, but the description is still in the help...
> 
> 
> # config HIGH_RES_TIMER_ACPI_PM
> #       bool "ACPI-pm-timer"
> 
> Is the pm timer incompatible with the RT portion of this patch?

The only timesource I came around to fixup is TSC in combination with
PIT or preferred Local APIC. Add "lapic" to your kernel command line for
UP boxen. Therefor it is disabled for now.

> I'm looking into getting HRT and RT booting on a SUMMIT NUMA machine 
> (cyclone timer), but after s/error/warning/ in arch/i386/timers/timer.c 
> for the HRT cyclone ifdef, I still get the following link error:

It should be simple to fix this. Just not right now. I have no such box
and restricted time resources. Can you test a patch when I find a slot?
But of course you are heartely invited to fix it yourself :)

tglx


