Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261717AbSJJQaa>; Thu, 10 Oct 2002 12:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261722AbSJJQa3>; Thu, 10 Oct 2002 12:30:29 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:38282 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S261717AbSJJQa2> convert rfc822-to-8bit; Thu, 10 Oct 2002 12:30:28 -0400
Message-ID: <180577A42806D61189D30008C7E632E8793ABD@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: "'szonyi calin'" <caszonyi@yahoo.com>, linux-kernel@vger.kernel.org
Subject: RE: Device Driver
Date: Thu, 10 Oct 2002 12:36:05 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the response. I figured out the problem. I included
linux/modversions.h in my makefile and now it works (silly mistake on my
part).

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com


-----Original Message-----
From: szonyi calin [mailto:caszonyi@yahoo.com]
Sent: Thursday, October 10, 2002 11:21 AM
To: Bloch, Jack; linux-kernel@vger.kernel.org
Subject: Re: Device Driver


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
