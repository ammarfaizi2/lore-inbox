Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbTEKLP7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 07:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbTEKLP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 07:15:58 -0400
Received: from ns.indranet.co.nz ([210.54.239.210]:5576 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id S261227AbTEKLP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 07:15:57 -0400
Date: Sun, 11 May 2003 23:28:25 +1200
From: Andrew McGregor <andrew@indranet.co.nz>
To: Tuncer M zayamut Ayaz <tuncer.ayaz@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
Message-ID: <3191078.1052695705@[192.168.1.249]>
In-Reply-To: <1405.1052575075@www9.gmx.net>
References: <1405.1052575075@www9.gmx.net>
X-Mailer: Mulberry/3.0.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try this (which will make no difference to the effectiveness of APM on this 
machine):

> CONFIG_PM=y
>
> CONFIG_APM=y
> CONFIG_APM_DO_ENABLE=n
> CONFIG_APM_CPU_IDLE=n
> CONFIG_APM_DISPLAY_BLANK=y
> CONFIG_APM_REAL_MODE_POWER_OFF=y
>
> CONFIG_CPU_FREQ=n
> CONFIG_CPU_FREQ_TABLE=n
>
> CONFIG_X86_SPEEDSTEP=n

Reasoning:
cpufreq and speedstep don't work on Dell P3 laptops anyway, and the 
*internal power supplies* of the i8x00 series make wierd noises when APM 
tries to idle the CPU.  The board will do this anyway, without making 
noise, so linux need not.

Andrew

--On Saturday, 10 May 2003 3:57 p.m. +0200 Tuncer M zayamut Ayaz 
<tuncer.ayaz@gmx.de> wrote:

> linux-2.5.69 (problem encountered since 2.5.67)
> DELL Inspiron 8100
>   - Pentium3-M
>   - ESS Maestro3
>   - Intel chipset
>   - builtin eepro100
>   - builtin lucent winmodem (not used)
>   - builtin nVidia GeForce2 Go (yes happens without nvdia.com driver too)
>   - BIOS A15
>
> using vanilla Debian GNU/Linux sid without incorporation of
> Debian's kernel-package mechanism.
>
> ever since I've run ALSA's snddevices script to create the needed /dev
> entries the laptop creates a permanent low-volume high tone (beep-like,
> but definitely not sounding like a normal pc-speaker).

> CONFIG_PM=y
>
> CONFIG_APM=y
> CONFIG_APM_DO_ENABLE=y
> CONFIG_APM_CPU_IDLE=y
> CONFIG_APM_DISPLAY_BLANK=y
> CONFIG_APM_REAL_MODE_POWER_OFF=y
>
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_TABLE=y
>
> CONFIG_X86_SPEEDSTEP=y

