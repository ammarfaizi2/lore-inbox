Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287006AbRL1URk>; Fri, 28 Dec 2001 15:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287000AbRL1URc>; Fri, 28 Dec 2001 15:17:32 -0500
Received: from mout0.freenet.de ([194.97.50.131]:16866 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S284141AbRL1URZ>;
	Fri, 28 Dec 2001 15:17:25 -0500
Message-ID: <3C2CCB82.7010309@athlon.maya.org>
Date: Fri, 28 Dec 2001 20:44:02 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011225
X-Accept-Language: en-us
MIME-Version: 1.0
To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre1
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,


Marcelo Tosatti wrote:


 > - Update Athlon/VIA PCI quirks			(Calin A.
 > 		 
				Culianu)

I tested this patch and unfortunately, I have to say, it is not working
(if it should prevent the suddenly changing time on VIA-boards).
I have the same problem with suddenly changing time as without this patch.

Furthermore, there are these entries in messages. They came in while
printing via parport to printer HP6P.

Dec 28 18:34:09 athlon kernel: DMA write timed out
Dec 28 18:34:35 athlon kernel: DMA write timed out
Dec 28 18:35:01 athlon kernel: DMA write timed out
Dec 28 18:35:52 athlon last message repeated 2 times
Dec 28 18:36:17 athlon kernel: DMA write timed out
Dec 28 18:37:09 athlon last message repeated 2 times
Dec 28 18:37:32 athlon kernel: DMA write timed out
Dec 28 18:37:59 athlon kernel: DMA write timed out
Dec 28 18:38:25 athlon kernel: DMA write timed out
Dec 28 18:38:51 athlon kernel: DMA write timed out

Kernel tells that lp0 uses
"lp0: ECP mode".

I configured in modules.conf:
	alias parport_lowlevel  parport_pc
	options parport_pc      io=0x278 irq=5 dma=3
which should be correct regarding bios configurations.

Unfortunately I can't say, if these entries came in before or after the
problem with the changing time.

The entries in messages and the time changing problem appeared during a 
lot of diskusage (io).



Regards,
Andreas Hartmann

