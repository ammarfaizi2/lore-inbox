Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288174AbSAHQlx>; Tue, 8 Jan 2002 11:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288169AbSAHQlo>; Tue, 8 Jan 2002 11:41:44 -0500
Received: from pollux.et6.tu-harburg.de ([134.28.85.242]:52231 "HELO
	mail.et6.tu-harburg.de") by vger.kernel.org with SMTP
	id <S288166AbSAHQlb>; Tue, 8 Jan 2002 11:41:31 -0500
Message-ID: <3C3B2139.6010103@tu-harburg.de>
Date: Tue, 08 Jan 2002 17:41:29 +0100
From: Sebastian Zimmermann <S.Zimmermann@tu-harburg.de>
Organization: Technische =?ISO-8859-15?Q?Universit=E4t?= Hamburg-Harburg
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011213
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: I2O and Promise SuperTrak SX6000 Kernel Oops
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to everyone that helped us with i2o and the Promise SuperTrak 
SX6000. However, there is still something strange that we cannot fix:

When the system is powered up, the SuperTrak BIOS is initializing the 
adapter. If we manually *abort* the initialization, Linux will boot 
without problems and we can use the hardware raid.

However, if we let the controller initialze the adapter (that is the 
default), the kernel will always Oops when I2O is loaded:

Oops: 0000
Call Trace: 
[<c01f7fd6>][<c0107d6d>][<c0107ed6>][<c0105150>][<c0105150>][<c0109d48>][<c0105150>][<c0105150>][<c0105173>][<c01051d9>][<c0105000>][<c0105027>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c01f7fd6 <i2o_pci_interrupt+a/14>
Trace; c0107d6c <handle_IRQ_event+30/5c>
Trace; c0107ed6 <do_IRQ+6a/a8>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0109d48 <call_do_IRQ+6/e>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0105172 <default_idle+22/28>
Trace; c01051d8 <cpu_idle+40/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105026 <rest_init+26/28>


Please help ;-)

Sebastian

P.S.: this happens with all kernels that we tried (2.4.7, 2.4.9, 2.4.14, 
2.4.17)

