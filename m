Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287293AbSAGWOn>; Mon, 7 Jan 2002 17:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287290AbSAGWOb>; Mon, 7 Jan 2002 17:14:31 -0500
Received: from quattro-eth.sventech.com ([205.252.89.20]:61712 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S287289AbSAGWOL>; Mon, 7 Jan 2002 17:14:11 -0500
Date: Mon, 7 Jan 2002 17:14:11 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: "=?iso-8859-1?Q?J=F6rn_Nettingsmeier?=" 
	<nettings@folkwang-hochschule.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 usbnet usb.c: USB device not accepting new address
Message-ID: <20020107171411.O10145@sventech.com>
In-Reply-To: <mailman.1010437020.13415.linux-kernel2news@redhat.com> <200201072141.g07Lf3102857@devserv.devel.redhat.com> <20020107164415.N10145@sventech.com> <3C3A1D42.9566EB24@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C3A1D42.9566EB24@folkwang-hochschule.de>; from nettings@folkwang-hochschule.de on Mon, Jan 07, 2002 at 11:12:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002, Jörn Nettingsmeier <nettings@folkwang-hochschule.de> wrote:
> Johannes Erdfelt wrote:
> > 
> > On Mon, Jan 07, 2002, Pete Zaitcev <zaitcev@redhat.com> wrote:
> > > >  kernel: usb.c: USB device not accepting new address=6 (error=-110)
> > >
> > > And your /proc/interrupts is ... ?
> > 
> > Almost definately > 0. He was getting hard CRC/Timeout's out of the HC.
> 
> before plugging the ipaq in again:
>   
>  19:     198150     198207   IO-APIC-level  aic7xxx, eth0, usb-uhci
> NMI:          0          0
> LOC:    2554011    2553990
> ERR:          0
> MIS:          0
> 
> after plugging in: (doing `cat interrupts` continuously)
> 
>  19:     198178     198233   IO-APIC-level  aic7xxx, eth0, usb-uhci
> NMI:          0          0
> LOC:    2555170    2555148
> ERR:          0
> MIS:          0
> 
>  19:     198187     198241   IO-APIC-level  aic7xxx, eth0, usb-uhci
> NMI:          0          0
> LOC:    2555323    2555301
> ERR:          0
> MIS:          0
> 
>  19:     198192     198248   IO-APIC-level  aic7xxx, eth0, usb-uhci
> NMI:          0          0
> LOC:    2555437    2555416
> ERR:          0
> MIS:          0
> 
>  19:     198194     198250   IO-APIC-level  aic7xxx, eth0, usb-uhci
> NMI:          0          0
> LOC:    2555515    2555494
> ERR:          0
> MIS:          0
> 
> i just realized i might have an issue with shared irqs here. aic7xxx
> has my system disk, and eth0 is a realtek 8139too.o
> aic7xxx and usb are on-board, so there's nothing i can do against
> them sharing an interrupt. i might shuffle my nic around tomorrow,
> if you guys think that it makes a difference.

It shouldn't. It seems to be getting the interrupts correctly since we
saw the CRC/Timeo from the HC.

JE

