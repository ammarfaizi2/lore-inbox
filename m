Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317171AbSGHVpX>; Mon, 8 Jul 2002 17:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317176AbSGHVpW>; Mon, 8 Jul 2002 17:45:22 -0400
Received: from 62-190-218-53.pdu.pipex.net ([62.190.218.53]:11020 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S317171AbSGHVpU>; Mon, 8 Jul 2002 17:45:20 -0400
From: jbradford@dial.pipex.com
Message-Id: <200207082150.WAA03372@darkstar.example.net>
Subject: Re: ISAPNP SB16 card with IDE interface
To: mouschi@wi.rr.com (Ted Kaminski)
Date: Mon, 8 Jul 2002 22:50:55 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000d01c226ac$436ad360$8a981d41@wi.rr.com> from "Ted Kaminski" at Jul 08, 2002 01:21:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Are you sure that the CD-ROM drive is jumpered correctly, because Windows may well not complain if it is set to 'slave', but alone on the bus.

Also, maybe I'm just being stupid, but why is it being recognised as ide3?  The numbering starts at 0, so if this is your third interface, it should be ide2.  Could you post a less-trimmed copy of your dmesg output to the list, (or just to me, if it'll annoy the list people).

Cheers,

John.

> 
> (Please CC to my address)
> 
> I've been trying for weeks now and seem to have exhausted every resource i
> can find, except this one...
> 
> I trying to get a 486 system booting to a 2.4.18 kernel to recognize a CDROM
> (a 4x one, model CR-581J, creative labs) connected to a ISAPNP Sound Blaster
> 16 card with an IDE interface on it. (99% sure actual IDE interface, not one
> of those old non-everything ones, SB is model CT2950)
> 
> The system is completely functional running Windows 95, so the hardware
> works.  I've also pretty much ruled out hardware conflicts because I've
> stripped it down to the bare bones...
> 
> I can't get all the boot messages here (i have to retype them), but the
> relevant portion is this:
> 
> ide3: Creative SB16 PnP IDE interface
> ...
> hdg: probing with STATUS(0x00) instead of ALTSTATUS(0x80)
> hdg: MATSHITA CR 581, ATAPI CD/DVD-Rom drive
> ...
> ide3 at 0x168-1x16f,0x36e on irq 10
> ...(displays CHS stuff for HD)...
> hdg: irq timeout: status=0x51 { DriveReady SeekComplete Error }
> hdg: irq timeout: error=0x60
> hdg: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> hdg: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> hdg: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> hdg: ATAPI reset complete
> 
> and it repeats from the irq timeout again before it end_request's
> 
> I'm somewhat perplexed, as I have not been able to find a solution to
> this... although i did find this
> 
> http://groups.google.com/groups?threadm=linux.kernel.20011203171651.GA2149%4
> 0man.beta.es&rnum=1
> 
> but my system doesn't have a PnP BIOS, so it seems that i can't
> do that method. !#@
> 
> Ted Kaminski
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

