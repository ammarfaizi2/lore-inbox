Return-Path: <linux-kernel-owner+w=401wt.eu-S1751323AbXAUJ7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbXAUJ7i (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 04:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbXAUJ7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 04:59:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:43771 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbXAUJ7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 04:59:37 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SiS58fKZ4VDCS0l0eI2e/iukXL+7fnz4K1J67aNkimS/x6cUtru7mnLWXkPQODZ554NLY1tJu2p9TggZhpaDmbNucHa0sYO3aH/CQ6Gn7VTsEpDkI8um1i78UJuCFKGDVjrtiKxvOPNH45Rd4t/XisZLX1x0sPEa/EjpIbOW5N0=
Message-ID: <8355959a0701210159k2fcb2323s2d38f91a41fcb942@mail.gmail.com>
Date: Sun, 21 Jan 2007 15:29:35 +0530
From: "Sunil Naidu" <akula2.shark@gmail.com>
To: "Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Running Linux on FPGA
Cc: linux-kernel@vger.kernel.org,
       "sathesh babu" <sathesh_edara2003@yahoo.co.in>,
       linux-mips@linux-mips.org
In-Reply-To: <20070121001457.GA9123@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070120234237.49126.qmail@web7912.mail.in.yahoo.com>
	 <20070121001457.GA9123@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/07, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> The overhead of timer interrupts at this low clockrate is significant
> so I recommend to minimize the timer interrupt rate as far as possible.
> This is really a tradeoff between latency and overhead and matters
> much less on hardcores which run at hundreds of MHz.  For power sensitive
> applications lowering the interrupt rate can also help.  And that's alredy
> pretty much what you need to know, that is a 10ms  timer is fine.
>

I have worked with FPGA Linux system which is reconfigurable
on-the-fly by the 200Mhz ARM9 CPU running Debian Linux, Altera Cyclone
II FPGA is included on my TS-7300 board. Advantage is, Altera FPGA and
a dedicated high-speed bus between the CPU and FPGA provides a good
design scope to provide many solutions.

Coming to boot up (by an USB 1GB SD card), by doing enough software
tuning bootup to a Linux prompt takes just 1.69 seconds after
power-up. If I remember correctly, SD image will look at the state of
jumper 6 (should be put ON), the full Debian bootup will be bypassed
and the system will instead drop straight to a shell prompt. 1.69
seconds after power-on the serial console prompt is active and 2.41
seconds after power-on the video console is displayed.

This software is based on Debian & has a vendor supplied Linux boot
loader. Currently am working (slowly in free time) to bring the whole
thing to FC6.  Shall post the progres...

>
>   Ralf

~Akula2
