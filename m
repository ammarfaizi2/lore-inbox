Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291703AbSBNPEk>; Thu, 14 Feb 2002 10:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291706AbSBNPEa>; Thu, 14 Feb 2002 10:04:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24083 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291703AbSBNPEQ>; Thu, 14 Feb 2002 10:04:16 -0500
Subject: Re: NS Geode: Is it OK to enable TSC [2.4.x]
To: HEtheron@csir.co.za (Herman Theron)
Date: Thu, 14 Feb 2002 15:17:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <sc6be105.019@CS-IMO.CSIR.CO.ZA> from "Herman Theron" at Feb 14, 2002 04:08:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bNdt-0000Ge-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Normallly, you can only compile the kernel with the CONFIG_M586 option.
> Doing some experimentation, I enabled the TSC in the file:
> /usr/src/linux/arch/i386/kernel/setup.c (by commenting out the
> "clear_bit(X86_FEATURE_TSC...." for the GX processor in the function
> "init_cyrix". I then compiled the kernel then with CONFIG_M586MMX. So
> far the system is running non-stop (without any apparent problems) for
> 24 hours with a RTAI-application aswell.

Certain combinations of Geode/MediaGX and chipset fail because of problems
with the emulation of the pc timers. If your machine even boots without
a panic about that or hanging then its not afflicted. Someone sent a work
around for this problem to the kenrel list recently and its on my pile
of things to tidy up and merge.


