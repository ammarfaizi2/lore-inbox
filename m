Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261612AbSJJPPa>; Thu, 10 Oct 2002 11:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbSJJPPa>; Thu, 10 Oct 2002 11:15:30 -0400
Received: from web40603.mail.yahoo.com ([66.218.78.140]:60761 "HELO
	web40603.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261612AbSJJPP3>; Thu, 10 Oct 2002 11:15:29 -0400
Message-ID: <20021010152105.91927.qmail@web40603.mail.yahoo.com>
Date: Thu, 10 Oct 2002 17:21:05 +0200 (CEST)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re: Device Driver
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>, linux-kernel@vger.kernel.org
In-Reply-To: <180577A42806D61189D30008C7E632E8793AB7@boca213a.boca.ssc.siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- "Bloch, Jack" <Jack.Bloch@icn.siemens.com> a écrit : > I
have written a device driver for a cPCI device. Thsi device
> driver loads
> and runs successfully when my application starts (I call
> /sbin/insmod).
> However,  when I add the following line to /etc/modules.conf
> 
> alias ifp0 Icdrva0s             /* my device is called ifp0
> and the driver
> Icdrva0s.o is stored in
> /lib/modules/2.4.18-3/kernel/drivers/net */
> 
> I get depmod errors. When I run depmod -e, I see that it is
> complaining
> about all kinds of regular symbols (ioremap,
> pci_register_driver to name but
> a few). What am I doing wrong? Please CC me directly on any
> responses.
> 

Hi

What System.map do you use for depmod ?
If you do a man depmod you can see that it has an algorithm
for finding the System.map. But maybe the case that 
depmod thins that your System.map is in another directory.

I think it's better to specify manually the system map
from your kernel tree (i.e. /usr/src/linux/System.map)

Bye
Calin
> 
> Thanks in advance,
> 
> Jack Bloch 
> Siemens ICN
> phone                (561) 923-6550
> e-mail                jack.bloch@icn.siemens.com
> 


=====
--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
