Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbUDJQSH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 12:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUDJQSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 12:18:06 -0400
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:52485 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S262043AbUDJQSD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 12:18:03 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Kitt Tientanopajai <kitt@gear.kku.ac.th>
Subject: Re: 2.6.5 yenta_socket irq 10: nobody cared!
Date: Sat, 10 Apr 2004 18:14:41 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200404060227.58325.daniel.ritz@gmx.ch> <200404091941.20444.daniel.ritz@gmx.ch> <20040410101825.59158e43.kitt@gear.kku.ac.th>
In-Reply-To: <20040410101825.59158e43.kitt@gear.kku.ac.th>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404101814.41955.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 April 2004 05:18, Kitt Tientanopajai wrote:
> Hi
> 
> > > > you're welcome. but i now have the feeling that it's wrong. so another question:
> > > > my patch also changes the interrupt assignment for the USB controller at 00:1d.1
> > > > so the question is: does this one work ok? or is there an interrupt storm as soon
> > > > as you use the device? (like with yenta_socket before)
> > > 
> > > Ah, right, TM361 has two USB ports, one of them has usb mouse attached and seem to be okay.
> > > Another one does not work after applying your patch. This is dmesg when I connect Sony Clie to
> > > sync data through the USB port, the pilot-xfer cannot sync any data and then exit without any
> > > crash/freeze. 
> > 
> > with my first patch applied, does the mouse work on the second port?
> 
> Yes, usb mouse works. And when I discovered that clie sync did not work on on one port, I just replace mouse with clie sync cable, and sync data through it successfully.
> 

so you say with my first patch both USB ports are working then? so clie sync only
works on one of the ports but the mouse on both?

> > could you try to replace the function o2micro_override() in drivers/pcmcia/o2micro.h
> > with this one?
> 
> replaced, and here is the dmesg.
> 

ok, it's the interrupt routing, not the chip config. i think the first patch that
adds the tm361 to the dmi_scan problem table is correct then. real good
QA from acer: hack the BIOS, boot it with windows and if it works, ship it...
it works with windows because it assigned all the devices to the same irq

i'll submit it later to andrew morton.

rgds
-daniel

