Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbTJJB02 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 21:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTJJB02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 21:26:28 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:36282 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262738AbTJJB0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 21:26:25 -0400
To: andersen@codepoet.org
Cc: Greg Stark <gsstark@MIT.EDU>, Jeff Garzik <jgarzik@pobox.com>,
       Philippe Lochon <plochon.n0spam@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: P4C800E-Dlx: ICH5/S-ATA and Intel Pro onboard network incompatibility ?
References: <3F7EDCDD.7090500@free.fr> <20031004180338.GA24607@codepoet.org>
	<20031004192733.GA30371@gtf.org> <20031004195342.GA25328@codepoet.org>
	<20031005201638.GB4259@codepoet.org> <87r81l9a9u.fsf@stark.dyndns.tv>
	<20031010010629.GA20873@codepoet.org>
In-Reply-To: <20031010010629.GA20873@codepoet.org>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 09 Oct 2003 21:26:24 -0400
Message-ID: <87fzi19933.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Erik Andersen <andersen@codepoet.org> writes:

> Do check your /proc/interrupts though.  With my P4P800 I found
> that when set to Enhanced mode, and when ide-scsi was carefully
> avoided, I was still getting a storm of interrupts that were
> doing rather bad things for system performance.  Can you check if
> you are also seeing the same thing?  i.e. does the interrupt line
> with your ide controller(s) on it show bazillions of interrupts?

Well I'm not really sure what numbers would be reasonable here, but these
don't seem insane to me.

bash-2.05b$ uptime
 21:24:57 up 7 days, 10:41, 10 users,  load average: 0.10, 0.07, 0.01


           CPU0       CPU1       
  0:   64325490          0    IO-APIC-edge  timer
  1:     629096          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:   40215382          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 12:    5479273          0    IO-APIC-edge  PS/2 Mouse
 14:     382236          1    IO-APIC-edge  ide0
 15:         63          0    IO-APIC-edge  ide1
 17:    5379508          0   IO-APIC-level  Intel ICH5
 18:    4574111          2   IO-APIC-level  ide3
 22:   26963560          0   IO-APIC-level  SysKonnect SK-98xx
NMI:          0          0 
LOC:   64325091   64325140 
ERR:          0
MIS:          2

-- 
greg

