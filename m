Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318191AbSIJWTe>; Tue, 10 Sep 2002 18:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318182AbSIJWSr>; Tue, 10 Sep 2002 18:18:47 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:16629
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318190AbSIJWSc>; Tue, 10 Sep 2002 18:18:32 -0400
Subject: Re: Linux 2.4.20-pre6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andreas.kerl@dts.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D7E6675.5080303@dts.de>
References: <3D7E6675.5080303@dts.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 10 Sep 2002 23:26:33 +0100
Message-Id: <1031696793.2726.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-10 at 22:39, Andreas Kerl wrote:
> Hi,
> same problem here.
> Kernel crashes at boot:
> 
> .......
> ICH3M: IDE Controller on PCI bus 0 dev f9
> PCI: Device 00:1f.1 not available becaus of resource collisions
> PCI: Assigned IRQ11 for device 00:1f.1
> Unable to handle kernel NULL pointer dereference at virtual address 00000010
> 

The diff I sent Marcelo was slightly the wrong one - the printk argument
is missing which I guess is what is causing the mess.

It should be  

          printk(KERN_INFO "%s: BIOS setup was incomplete.\n", d->name);
  


