Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTEKMvJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 08:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTEKMvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 08:51:09 -0400
Received: from pop.gmx.net ([213.165.64.20]:169 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261311AbTEKMvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 08:51:08 -0400
Date: Sun, 11 May 2003 15:03:45 +0200 (MEST)
From: Tuncer M "zayamut" Ayaz <tuncer.ayaz@gmx.de>
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <3191078.1052695705@[192.168.1.249]>
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0007628267@gmx.net
X-Authenticated-IP: [217.224.154.184]
Message-ID: <17308.1052658225@www4.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Try this (which will make no difference to the effectiveness of APM on
> this 
> machine):
> 
> > CONFIG_PM=y
> >
> > CONFIG_APM=y
> > CONFIG_APM_DO_ENABLE=n
> > CONFIG_APM_CPU_IDLE=n
> > CONFIG_APM_DISPLAY_BLANK=y
> > CONFIG_APM_REAL_MODE_POWER_OFF=y
> >
> > CONFIG_CPU_FREQ=n
> > CONFIG_CPU_FREQ_TABLE=n
> >
> > CONFIG_X86_SPEEDSTEP=n
> 
> Reasoning:
> cpufreq and speedstep don't work on Dell P3 laptops anyway, and the 
> *internal power supplies* of the i8x00 series make wierd noises when APM 
> tries to idle the CPU.  The board will do this anyway, without making 

hmm, at least now I know where that strange sound comes from.
I'm not quite sure that SpeedStep does not work,
with SpeedStep disabled in the BIOS the fans turned on again with
cpu load. this doesn't happen with SpeedStep. so I suppose it works
to some extent, right?

> noise, so linux need not.

so what options should I set?
as I've already stated it's not bearable to do coding (incl. compiling)
on this box without "Battery Optimized Mode" as SpeedStep calls it.
on Linux I did that with a simple tool called speedstep.
I've seen autospeedstep from Fritz Ganter which seems to use ACPI,
dunno how that compares to cpufreqd.

anyway, this laptop is not-so-nice anyway, I'm just happy I didn't
buy it but my employer did ;)

-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
Bitte lächeln! Fotogalerie online mit GMX ohne eigene Homepage!

