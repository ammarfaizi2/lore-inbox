Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267611AbTALWp6>; Sun, 12 Jan 2003 17:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267610AbTALWp6>; Sun, 12 Jan 2003 17:45:58 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:40345 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S267611AbTALWou>; Sun, 12 Jan 2003 17:44:50 -0500
Message-ID: <4967145.1042411725110.JavaMail.nobody@web55.us.oracle.com>
Date: Sun, 12 Jan 2003 14:48:45 -0800 (PST)
From: Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>
To: andrew.grover@intel.com
Subject: Re: Kernel 2.5.55 failed to boot with ACPI support 
Cc: olehag_2001@yahoo.no, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Grover wrote:

> > From: Ole J. Hagen [mailto:olehag_2001@yahoo.no] 
> > I just wanted to inform that kernel-2.5.55 failes to boot 
> > when ACPI support is 
> > compiled in the kernel. 
> > 
> > I have following configuration; Dell Optiplex GX-240, Pentium 
> > 4 (1.5 GHz), ATI RAGE 128.
>
> How exactly does it fail?

My brand new Dell Latitude C640 oopses on boot in 2.5.56 if I
 have CPU_FREQ config'd in. ACPI without CPU_FREQ is okay - well,
 it screws my framebuffer screen (what 2.4.21-pre3 doesn't) when
 the ACPI code does its bootup printk's, but after that the
 screen recovers.

Another thing is that /proc/acpi/fan is empty despite my setting
 of CONFIG_ACPI_FAN=y.

Oh, and one more - /proc/acpi/battery/BAT0/state claims

charging state: unknown

 as well as

present rate:       0 mA
remaining capacity: 0 mAh
present voltage:    0 mV

 and the info file, when cat'd, prints a few times

dsobject-0188: *** Warning: Buffer created with zero length in AML


Back on topic, if you're interested I can rebuild my 2.5.56 with
 CPU_FREQ and write down the backtrace of the oops.

--alessandro
