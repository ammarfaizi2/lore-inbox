Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287287AbSAGWNC>; Mon, 7 Jan 2002 17:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287284AbSAGWMx>; Mon, 7 Jan 2002 17:12:53 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:16344 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S287276AbSAGWMh>; Mon, 7 Jan 2002 17:12:37 -0500
Message-ID: <3C3A1D42.9566EB24@folkwang-hochschule.de>
Date: Mon, 07 Jan 2002 23:12:18 +0100
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier 
	<nettings@folkwang-hochschule.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Johannes Erdfelt <johannes@erdfelt.com>
CC: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 usbnet usb.c: USB device not accepting new address
In-Reply-To: <mailman.1010437020.13415.linux-kernel2news@redhat.com> <200201072141.g07Lf3102857@devserv.devel.redhat.com> <20020107164415.N10145@sventech.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Erdfelt wrote:
> 
> On Mon, Jan 07, 2002, Pete Zaitcev <zaitcev@redhat.com> wrote:
> > >  kernel: usb.c: USB device not accepting new address=6 (error=-110)
> >
> > And your /proc/interrupts is ... ?
> 
> Almost definately > 0. He was getting hard CRC/Timeout's out of the HC.
> 
> JE

before plugging the ipaq in again:
  
 19:     198150     198207   IO-APIC-level  aic7xxx, eth0, usb-uhci
NMI:          0          0
LOC:    2554011    2553990
ERR:          0
MIS:          0

after plugging in: (doing `cat interrupts` continuously)

 19:     198178     198233   IO-APIC-level  aic7xxx, eth0, usb-uhci
NMI:          0          0
LOC:    2555170    2555148
ERR:          0
MIS:          0

 19:     198187     198241   IO-APIC-level  aic7xxx, eth0, usb-uhci
NMI:          0          0
LOC:    2555323    2555301
ERR:          0
MIS:          0

 19:     198192     198248   IO-APIC-level  aic7xxx, eth0, usb-uhci
NMI:          0          0
LOC:    2555437    2555416
ERR:          0
MIS:          0

 19:     198194     198250   IO-APIC-level  aic7xxx, eth0, usb-uhci
NMI:          0          0
LOC:    2555515    2555494
ERR:          0
MIS:          0


i just realized i might have an issue with shared irqs here. aic7xxx
has my system disk, and eth0 is a realtek 8139too.o
aic7xxx and usb are on-board, so there's nothing i can do against
them sharing an interrupt. i might shuffle my nic around tomorrow,
if you guys think that it makes a difference.



-- 
Jörn Nettingsmeier     
home://Kurfürstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/
