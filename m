Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbTEMMiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 08:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbTEMMiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 08:38:09 -0400
Received: from mx0.gmx.de ([213.165.64.100]:59703 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S261156AbTEMMiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 08:38:08 -0400
Date: Tue, 13 May 2003 14:50:47 +0200 (MEST)
From: Tuncer M "zayamut" Ayaz <tuncer.ayaz@gmx.de>
To: Troels Walsted Hansen <troels@thule.no>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <3EC0E885.9070306@thule.no>
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0007628267@gmx.net
X-Authenticated-IP: [194.77.158.73]
Message-ID: <30051.1052830247@www47.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew McGregor wrote:
> > Try this (which will make no difference to the effectiveness of APM on 
> > this machine):
> > 
> >> CONFIG_PM=y
> >>
> >> CONFIG_APM=y
> >> CONFIG_APM_DO_ENABLE=n
> >> CONFIG_APM_CPU_IDLE=n
> >> CONFIG_APM_DISPLAY_BLANK=y
> >> CONFIG_APM_REAL_MODE_POWER_OFF=y
> >>
> >> CONFIG_CPU_FREQ=n
> >> CONFIG_CPU_FREQ_TABLE=n
> >>
> >> CONFIG_X86_SPEEDSTEP=n
> > 
> > 
> > Reasoning:
> > cpufreq and speedstep don't work on Dell P3 laptops anyway, and the 
> > *internal power supplies* of the i8x00 series make wierd noises when APM
> 
> > tries to idle the CPU.  The board will do this anyway, without making 
> > noise, so linux need not.
> 
> My Dell Latitude C600 shows the exact same problem. I noticed it after 
> upgrading to from RH7.x to RH8 with kernel 2.4.18-27.8.0. I believe this 
> kernel is customized by RH to use HZ=500 or something in that region.
> 
> With your analysis of the problem I was able to remove the noise by 
> using the "apm=idle-threshold=100" parameter on the kernel commandline. 
> This turns off APM idle calls without requiring kernel recompilation.
> 
> Using the "i8k" kernel module, I have verified that the temperature of 
> the CPU is unchanged with APM idle turned off. I have not tried to 
> measure power consumption or battery use.

so, cool no need to turn that on at all then.
--> no kernel bug, just a case of bad internel psu inside an overpriced
laptop :D

> Thanks for the tip!

no problem. actually, I'm glad the thread I've started did help you
and also myself to understand the problem.

-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
Bitte lächeln! Fotogalerie online mit GMX ohne eigene Homepage!

