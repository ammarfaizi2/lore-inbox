Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277378AbRJJTnJ>; Wed, 10 Oct 2001 15:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277379AbRJJTnB>; Wed, 10 Oct 2001 15:43:01 -0400
Received: from femail47.sdc1.sfba.home.com ([24.254.60.41]:41153 "EHLO
	femail47.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S277378AbRJJTmq>; Wed, 10 Oct 2001 15:42:46 -0400
Message-ID: <000701c151c4$0e6933e0$0300a8c0@theburbs.com>
From: "Jamie" <darkshad@home.com>
To: <jgarzik@mandrakesoft.com>
Cc: <jam@McQuil.com>, <becker@webserv.gsfc.nasa.gov>, <andrea@e-mind.com>,
        <Torsten.Duwe@informatik.uni-erlangen.de>,
        <linux-kernel@vger.kernel.org>
Subject: Tulip problem in Kernel 2.4.11
Date: Wed, 10 Oct 2001 15:45:02 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 1
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there is a definate problem with the tulip drivers in the 2.4.11
kernel.
I have a DEC DC 21041 NIC which uses the tulip drivers.  I use the 2.2.19
kernel and there are
two different sets of tulip drivers listed in that kernel which I can choose
from in the 2.4.11 kernel there is only one. When I do a modprobe tulip the
driver loads fine as you can see bellow there are no strange error messages
ect.  But I can not communicate though this one NIC. When I use the 2.2.19
Kernel it works fine.

I even tried copying the .config file over from the 2.2.19 to the 2.4.11 to
ensure that they would be the same options.

It works fine with the 2.2.19 Kernel but with the 2.4.11 the driver is not
functioning correctly.


Oct 10 15:12:25 CS623805-A kernel: Linux Tulip driver version 0.9.15-pre7
(Oct 2
, 2001)
Oct 10 15:12:25 CS623805-A kernel: tulip0: 21041 Media table, default media
0800
 (Autosense).
Oct 10 15:12:25 CS623805-A kernel: tulip0:  21041 media #0, 10baseT.
Oct 10 15:12:25 CS623805-A kernel: tulip0:  21041 media #4, 10baseT-FDX.
Oct 10 15:12:25 CS623805-A kernel: eth0: Digital DC21041 Tulip rev 17 at
0x6100,
 21041 mode, 00:00:C0:90:F0:E3, IRQ 3.
Oct 10 15:12:32 CS623805-A sendmail[116]: starting daemon (8.11.4):
SMTP+queuein
g@00:15:00
Oct 10 15:12:34 CS623805-A kernel: 00:0b.0: 3Com PCI 3c900 Cyclone 10Mbps
TPO at
 0x6200. Vers LK1.1.16

As per the headings in the tulip_core.c this is maintained by Jeff which is
the reason why I am emailing you about this issue.

/* tulip_core.c: A DEC 21x4x-family ethernet driver for Linux. */

/*
        Maintained by Jeff Garzik <jgarzik@mandrakesoft.com>
        Copyright 2000,2001  The Linux Kernel Team
        Written/copyright 1994-2001 by Donald Becker.

        This software may be used and distributed according to the terms
        of the GNU General Public License, incorporated herein by reference.

        Please refer to Documentation/DocBook/tulip.{pdf,ps,html}
        for more information on this driver, or visit the project
        Web page at http://sourceforge.net/projects/tulip/

*/

#define DRV_NAME        "tulip"
#define DRV_VERSION     "0.9.15-pre7"
#define DRV_RELDATE     "Oct 2, 2001"


And also the headings from the 2.2.19 Kernel for the tulip.c

/* tulip.c: A DEC 21040-family ethernet driver for Linux. */
/*
        Written/copyright 1994-1999 by Donald Becker.

        This software may be used and distributed according to the terms
        of the GNU Public License, incorporated herein by reference.

        This driver is for the Digital "Tulip" Ethernet adapter interface.
        It should work with most DEC 21*4*-based chips/ethercards, as well
as
        with work-alike chips from Lite-On (PNIC) and Macronix (MXIC) and
ASIX.

        The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
        Center of Excellence in Space Data and Information Sciences
           Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771

        Support and updates available at
        http://cesdis.gsfc.nasa.gov/linux/drivers/tulip.html

        This driver also contains updates by Wolfgang Walter and others.
        For this specific driver variant please use linux-kernel for
        bug reports.

        Updated 12/17/2000 by Jim McQuillan <jam@McQuil.com> to

*/

#define SMP_CHECK
static const char version[] = "tulip.c:v0.91g-ppc 7/16/99
becker@cesdis.gsfc.nasa.gov\n";


I am hoping that you guys can figure out as to what is happening in the
2.4.11 kernel because it is very broken for this kernel. It is not working
what so ever. I know in the 2.2.19 there are 3 different choices for the DEC
card 2 of which make the tulip.o in the 2.4.11 there is only 1 and this one
is not working with this card. It is not communicating properly with this
NIC. All I get are time outs and not being able to connect to the DHCP
server.  When I use the 2.2.19 Kernel it works fine.  I pull an IP address
no problem. It is NOT an option that I have selected either in the 2.4.11
because they are the same config file.

Also in the read me it says that there was a few other people here that do
some kernel hacking so I am sending you this email as well to see what you
think about this.


N: Andrea Arcangeli
E: andrea@e-mind.com
W: http://e-mind.com/~andrea/
P: 1024/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
D: Parport hacker
D: Implemented a workaround for some interrupt buggy printers
D: Author of pscan that helps to fix lp/parport bug
D: Author of lil (Linux Interrupt Latency benchmark)
D: Fixed the shm swap deallocation at swapoff time (try_to_unuse message)
D: Various other kernel hacks


N: Torsten Duwe
E: Torsten.Duwe@informatik.uni-erlangen.de
D: Part-time kernel hacker
D: The Linux Support Team Erlangen
S: Grevenbroicher Str. 17
S: 47807 Krefeld
S: Germany



This is a definate tulip driver problem that I am having here if you guys
could look at this I would greatly appreciate it.



Thanks,

Jamie

