Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSFQQnV>; Mon, 17 Jun 2002 12:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315192AbSFQQnU>; Mon, 17 Jun 2002 12:43:20 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:12766 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S314829AbSFQQnS>; Mon, 17 Jun 2002 12:43:18 -0400
Message-ID: <3D0E0E5F.20406@drugphish.ch>
Date: Mon, 17 Jun 2002 18:29:19 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire Disks. (fwd)
References: <Pine.LNX.3.95.1020617081723.12517A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry for keeping you waiting.

> Well. I have been experimenting and a Firewire CD-R/W is found and
> accessible. However, a 80 Gb Maxtor hard disk is not. I had to
> copy from an RS-232C screen because the resounding crash(es) repeat
> forever until I hit the reset switch. <EOL> == "end of line with
> data missing after".
> 
> 
> ohci1394: $Revision: 1.80 $ Ben Collins <bcollins@debian.org>

Gulp, you should really be using a more recent copy of that driver. I'm 
running 1.91 from the CVS and I remember having had problems with the 
1.80 driver series too. I don't know why the ieee1394 tree is not pushed 
into the mainline kernel ...

Download the subversion client [1] and then follow the rest of the 
procedure on that page. Could you try and checkout the newest tree and 
simply replace the ieee1394 tree with the CVS one. You should probably 
also switch to a more recent 2.4.x tree since IIRC the .19 series has 
some changes to the scsi (emulation) subsystem.

> ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9] MMIO=[febfd000-febfe000] Max
> Packet=[ <EOL>
> ieee1394: Device added: Node 0:1023, GUID 00063a0245003973
> ieee1394: sbp2: Driver forced to serialize I/O (serialize_io = 1)
> ieee1394: sbp2: Node 0:1023: Max speed [S400] - Max payload [1024]
> scsi2 : IEEE-1394 SBP-2 protocol driver
> scsi: unknown type 24
>   Vendor: GHIJKLMN  Model: OPQRSTUVWXYZ     Rev: "Unprintable junk"
>   Type:   Unknown                           ANSI SCSI revision: 03
> resize_dma_pool: unknown device type 24
> 
> 
> Startup messages continue without further references to either SCSI
> or IEEE1394. The crash occurs when my SCSI root-file system is first
> referenced after initrd completes (pivot_root).
> 
> When this 80 Gb drive is used under W$, on the same machine, I see
> no evidence of "GHIJKLMN" or "OPQRSTUVWXYZ" although the device-manager
> doesn't let you read physical device info like it does with SCSI.
> 
> Number 24, shown above, is ^X, not part of the obvious
>  "ABCDEFGHIJKLMNOPQRSTUVWXYZ" string that we see parts of above. So
> it doesn't look like a read from the wrong offset during the device-
> inquiry.
> 
> 
> I'm using Linux-2.4.18. Maybe there is a more "mature" version
> of sbp2 I should be using??

Could you try with the latest 2.4.19preX tree and also replace the 
../drivers/ieee1394 with the CVS one?

[1] http://linux1394.sourceforge.net/svn.html

Best regards,
Roberto Nibali, ratz

p.s.: You have to hurry up, since I'm not online very often the next few 
weeks. Of course you could also show up at OLS with the disk ;).
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

