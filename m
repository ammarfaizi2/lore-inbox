Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292594AbSCOO3M>; Fri, 15 Mar 2002 09:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292555AbSCOO3D>; Fri, 15 Mar 2002 09:29:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51723 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292589AbSCOO2s>; Fri, 15 Mar 2002 09:28:48 -0500
Subject: Re: [PATCH-RFC] POSIX Event Logging, kernel 2.5.6 & 2.4.18y
To: Tony.P.Lee@nokia.com
Date: Fri, 15 Mar 2002 14:44:28 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, kessler@us.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <4D7B558499107545BB45044C63822DDE3A2037@mvebe001.NOE.Nokia.com> from "Tony.P.Lee@nokia.com" at Mar 14, 2002 06:14:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lswW-0003oV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) If anyone is going to add this to the kernel, please make sure
> printk_improve also log the TSC, current_process_id (if avail), etc. =20
> Very useful for performance profiling and failure analysis.

We always have a guess at the current pid (current->pid is always safe
to talk about but in an IRQ its of questionable value. Since it tells you
what was running when it blew up it does sometimes help with stack
scribbes/overruns)

> 3) After that you need to get special BIOS so that we can log the=20
> buffer to a section of memory that is preserved after reset.  =20
> With this, you can easily postmortem diagnostic any problem that=20
> crash the kernel/ISR/Driver.   This is much easily to do in=20
> embedded projects as compare to PC, since we control the BIOS.

I've found that a lot of the 3dfx voodoo 4/5 boards are not cleared by
the firmware on boot up. This allows you to hide about 24Mb of logs in
the top of the card ram and recover it after a soft boot.

Alan
