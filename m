Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbTBTPLR>; Thu, 20 Feb 2003 10:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTBTPLR>; Thu, 20 Feb 2003 10:11:17 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:58128 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265051AbTBTPLQ>; Thu, 20 Feb 2003 10:11:16 -0500
Date: Thu, 20 Feb 2003 08:20:13 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Sahani Himanshu <honeyuee@iitr.ernet.in>, linux-kernel@vger.kernel.org
Subject: Re: Adaptec drivers causing problem in RHL 8.0
Message-ID: <1316810000.1045754413@aslan.scsiguy.com>
In-Reply-To: <Pine.GSO.4.05.10302201550440.2763-100000@iitr.ernet.in>
References: <Pine.GSO.4.05.10302201550440.2763-100000@iitr.ernet.in>
X-Mailer: Mulberry/3.0.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi All,
> 
> May be you will say that this has been answered somewhere, but I am not
> really able to understand what to do?
> 
> I recently installed RHL 8.0 on a SGI1200 server. The server has 
> "Adaptec AIC-7896 SCSI BIOS v2.20S1B1" installed.
> 
> When I boot the system, the two SCSI channels are recognised, and then the
> system is not able to initialise. The partial error codes are:
> 
> aic7xxx_abort returns 0x2002
> SCSI 0:0:0:0: Attempting to queue TARGET RESET message
> SCSI 0:0:0:0: Is not an active device

Those messages point to an interrupt routing problem.  The driver is
not able to see interrupts from the chip, so timeouts occur.  Have
you tries some of the various "apic/noapic" kernel options to see if
your interrupt routing improves?  Often switching between UP and
SMP kernels will change how interrupt routing is performed too.

--
Justin

