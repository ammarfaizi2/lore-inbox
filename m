Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262779AbSKIWIi>; Sat, 9 Nov 2002 17:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262782AbSKIWIi>; Sat, 9 Nov 2002 17:08:38 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:49808 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S262779AbSKIWIh>; Sat, 9 Nov 2002 17:08:37 -0500
Message-ID: <3DCD88EF.20400@quark.didntduck.org>
Date: Sat, 09 Nov 2002 17:15:11 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ognen Duzlevski <ognen@kc.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: parport question
References: <Pine.LNX.4.44.0211091258440.1456-100000@gemelli.dyndns.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ognen Duzlevski wrote:
> Hi,
> 
> I have sent this question to the people listed in the parport
> kernel directory (the maintainers) but have yet not received a reply and
> I am not sure if this is exactly a linux-kernel question.
> 
> I have a printer that worked fine under linux (redhat/lexmark 3200) for a
> long time, then I switched over to 2.4.18 and debian and it stopped
> working. I compiled the parport support into the kernel, I did that with
> 2.4.19, I did it also as modules, I tried 2.5.45, still won't work, not
> even a cat test.txt > /dev/lp0
> 
> The dmesg shows that the printer is recognized correctly:
> 
> Nov  9 13:06:32 gemelli kernel: parport0: PC-style at 0x378 (0x778)
> [PCSPP,TRISTATE]
> Nov  9 13:06:32 gemelli kernel: parport0: irq 5 detected
> Nov  9 13:06:34 gemelli kernel: parport0: Printer, Lexmark Lexmark 3200
> lp0: using parport0 (polling).
> lp0: console ready
> 
> The BIOS has a ton of settings such as "auto" or "normal" - I have tried
> them all, tried forcing the DMA / IRQ from the BIOS and then feeding these
> values to parport_pc, still won't work. I have tried all combinations of
> Normal, ECP, ECP+EPP or EPP solely, won't work.
> 
> I then installed vmware and windows nt as a guest OS, under the same
> kernels. I set up parport0 to be used by vmware and, it prints from
> Windows nt (so I know the printer is fully functional).
> 
> Any ideas, help would be appreciated. Sorry if this is not the place to
> post the question but I have tried google, linux-printing.org, usenet to
> no avail.
> 
> CHeers,
> Ognen

It sounds like a userspace problem.  The information about this printer 
I've found on the web shows it to be a GDI printer (ie. all the smarts 
are in the software driver, not in the printer), which means sending 
text to it will never print anything.  You will need to check the 
configuration of ghostscript or whatever userspace printer driver debian 
is using.

--
				Brian Gerst


