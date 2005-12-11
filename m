Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVLKRHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVLKRHB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 12:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVLKRHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 12:07:01 -0500
Received: from host-87-74-42-126.bulldogdsl.com ([87.74.42.126]:6888 "EHLO
	shell.skyblue.eu.org") by vger.kernel.org with ESMTP
	id S1750731AbVLKRHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 12:07:01 -0500
X-Antivirus-SKYBLUE-Mail-From: brent@skyblue.eu.org via shell
X-Antivirus-SKYBLUE: 1.25-st-qms (Clear:RC:1(172.21.1.101):. Processed in 0.048951 secs Process 32380)
From: "Brent" <brent@skyblue.eu.org>
To: "'Willy Tarreau'" <willy@w.ods.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: High load since upgrade
Date: Sun, 11 Dec 2005 17:06:41 -0000
Message-ID: <001a01c5fe75$42c9b030$3128fea9@mforma.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcX+XK/P3urnHmojQ8yJgn9ShyBmJwAGEuwg
In-Reply-To: <20051211130854.GA5258@alpha.home.local>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.
That was it. 
For anyone that ever runs into this I removed CONFIG_DELL_RBU from the
.config rebuilt the kernel and booted into it and now my load is hovering
around a decent 0.08 ish

Thanks for the help Willy

Cheers
Brent

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Willy Tarreau
> Sent: 11 December 2005 13:09
> To: Brent
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: High load since upgrade
> 
> Hi,
> 
> On Sun, Dec 11, 2005 at 12:54:45PM -0000, Brent wrote:
> > Almost everything is statically compiled apart from a few 
> things that 
> > I didn't feel like rebooting for.
> > I also put up the .config at 
> > http://pics.skyblue.eu.org/graphs/config.txt if you want to 
> check that out as well.
> > 
> > lon-gw:/var/log# lsmod
> > Module                  Size  Used by
> > 8250                   27380  0 
> > serial_core            25984  1 8250
> > lon-gw:/var/log#
> > 
> > 
> > USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   
> TIME COMMAND
> > root         1  0.0  0.0  1584  516 ?        S    Dec09   
> 0:01 init [2]  
> > root         2  0.0  0.0     0    0 ?        S    Dec09   
> 0:06 [migration/0]
> > root         3  0.0  0.0     0    0 ?        SN   Dec09   
> 0:00 [ksoftirqd/0]
> > root         4  0.0  0.0     0    0 ?        S    Dec09   
> 0:06 [migration/1]
> > root         5  0.0  0.0     0    0 ?        SN   Dec09   
> 0:00 [ksoftirqd/1]
> > root         6  0.0  0.0     0    0 ?        S<   Dec09   
> 0:00 [events/0]
> > root         7  0.0  0.0     0    0 ?        S<   Dec09   
> 0:00 [events/1]
> > root         8  0.0  0.0     0    0 ?        S<   Dec09   
> 0:00 [khelper]
> > root         9  0.0  0.0     0    0 ?        S<   Dec09   
> 0:00 [kthread]
> > root        12  0.0  0.0     0    0 ?        S<   Dec09   
> 0:00 [kacpid]
> > root        78  0.0  0.0     0    0 ?        S<   Dec09   
> 0:00 [kblockd/0]
> > root        79  0.0  0.0     0    0 ?        S<   Dec09   
> 0:00 [kblockd/1]
> > root        82  0.0  0.0     0    0 ?        S<   Dec09   
> 0:00 [khubd]
> > root       183  0.0  0.0     0    0 ?        S    Dec09   
> 0:00 [pdflush]
> > root       184  0.0  0.0     0    0 ?        S    Dec09   
> 0:00 [pdflush]
> > root       186  0.0  0.0     0    0 ?        S<   Dec09   
> 0:00 [aio/0]
> > root       185  0.0  0.0     0    0 ?        S    Dec09   
> 0:00 [kswapd0]
> > root       187  0.0  0.0     0    0 ?        S<   Dec09   
> 0:00 [aio/1]
> > root       771  0.0  0.0     0    0 ?        S<   Dec09   
> 0:00 [kseriod]
> > root       848  0.0  0.0     0    0 ?        S<   Dec09   
> 0:00 [scsi_eh_0]
> > root       881  0.0  0.0     0    0 ?        S<   Dec09   
> 0:00 [scsi_eh_1]
> > root       915  0.0  0.0     0    0 ?        S<   Dec09   
> 0:00 [scsi_eh_2]
> > root       961  0.0  0.0     0    0 ?        D    Dec09   
> 0:00 [firmware/dell_r]
>                                              ^^^^^            
>    ^^^^^^^^^^^^^^^
> 
> What's this kernel thread ? The fact that it's stuck in D 
> state makes me think it may be the responsible for the skewed 
> values you measure. Can you retry without it ? I don't know 
> where it comes from, maybe this is related to some of the 
> following discoveries, I don't know :
> 
> > scsi2 : LSI Logic MegaRAID driver
> > scsi[2]: scanning scsi channel 0 [Phy 0] for non-raid devices
> >   Vendor: DELL      Model: 1x3 U2W SCSI BP   Rev: 1.21
> >   Type:   Processor                          ANSI SCSI revision: 02
> (...)
> 
> > 0-002d: Using VRM: 8.2 adm9240 0-002d: status: config 0x03 mode 1 
> > i2c_adapter i2c-0: found LM81 revision 3 adm9240 0-002e: Using VRM: 
> > 8.2 adm9240 0-002e: status: config 0x03 mode 1 i2c_adapter 
> i2c-0: detect fail:
> > address match, 0x2f
> >  dcdbas: Dell Systems Management Base Driver (version 5.6.0-1)
> (...)
> 
> Regards,
> Willy
>  
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


