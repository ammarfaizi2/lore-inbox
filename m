Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266953AbUAXP2e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 10:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266955AbUAXP2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 10:28:32 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:41876
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S266953AbUAXP23
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 10:28:29 -0500
Date: Sat, 24 Jan 2004 10:39:19 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Illegal instruction with gl
Message-ID: <20040124103919.A7924@animx.eu.org>
References: <20040123181512.A6632@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20040123181512.A6632@animx.eu.org>; from Wakko Warner on Fri, Jan 23, 2004 at 06:15:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to add to the below, I disabled acpi, highmem, smp, and preempt.  Same
problem.  I also tried 2.4.24 kernel, same results.

I modified agpgart on 2.4.24 to use generic intel init which didn't change
anything.

This is the first system with an intel E7505 I've used so I don't know if
it's a board problem or a kernel problem.  Or if it's with the matrox g400.

Here's the kernel messages for agp/drm from 2.6.1 (everything enabled that I
disabled):
agpgart: Detected an Intel E7505 Chipset.
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 32M @ 0xf8000000
[drm] Initialized mga 3.1.0 20021029 on minor 0
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Device is in legacy mode, falling back to 2.x
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode

I placed some files in:
http:// veg.animx.eu.org/e7505/
with some extra information (config, full dmesg, lspci -v)

> I recently upgraded my system board and now gl stuff crashes with illegal
> instruction.
> 
> Here's the trace (space in url to keep off robots)
> http:// veg.animx.eu.org/strace.gl.txt
> 
> I'm using 2.6.1 SMP PREEMPT on a dual P4 Xeon 2.66ghz (1gb ram)
> 
> The board is a supermicro x5da8 (Intel e7505 chipset).  The card is a matrox
> g400 max 32mb dual head.  mga, intel_agp and agpgart are loaded.
> 
> Modifications to the kernel when I changed the board (old board was an intel
> chipset, same card with 384mb ram):
> Enabled ACPI
> Enabled PreEmpt
> Changed processor type to p4 (from pIII)
> Enabled SMP
> Enabled High mem (4GB)
> Enable aic79xx (aic7xxx is also enabled but not used) and changed the
> initial delay from 15000 to 1000
> 
> I also enabled new modules for the intel 1000 nic and the intel ICH ac97
> sound (both alsa and oss).
> 
> These are the only configuration changes.  I looked at the X log but saw
> nothing.  The kernel does not complain about anything.
> 
> If this is a known problem, please let me know.  I'm willing to try any
> troubleshooting to fix this problem.  Any more information available on
> request.
> 
> -- 
>  Lab tests show that use of micro$oft causes cancer in lab animals
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
