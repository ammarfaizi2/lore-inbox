Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbTLXVFk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 16:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTLXVFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 16:05:40 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:42690 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S263876AbTLXVF0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 16:05:26 -0500
Message-ID: <3FE9FF6F.50606@blue-labs.org>
Date: Wed, 24 Dec 2003 16:04:47 -0500
From: David Ford <david+hb@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20031222
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric <eric@cisu.net>
CC: linux-kernel@vger.kernel.org, lnz@dandelion.com
Subject: Re: 2.6.0 and VMWare Buslogic Error?
References: <200312241500.27156.eric@cisu.net>
In-Reply-To: <200312241500.27156.eric@cisu.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The BusLogic driver has had this problem for a long long time.  It works 
as long as nothing breaks... how's that for an answer ;)

David

Eric wrote:

>Hello, 
>	When booting the linux kernel 2.6.0 (and since 2.6.0-test9 when I started 
>using 2.6) I am not sure if I get it using 2.4 However my vague memory says 
>no.. I get this message on startup. I am using VMWare Workstation 4.0.5 build 
>6030.
>
>scsi: ***** BusLogic SCSI Driver Version 2.1.16 of 18 July 2002 *****
>scsi: Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
>ERROR: SCSI host `BusLogic' has no error handling
>ERROR: This is not a safe way to run your SCSI host
>ERROR: The error handling must be added to this driver
>Call Trace:
> [<c0213068>] scsi_host_alloc+0x77/0x288
> [<c0213289>] scsi_register+0x10/0x51
> [<c03349b5>] BusLogic_DetectHostAdapter+0x1ae/0x32e
> [<c0335345>] init_this_scsi_driver+0x51/0xce
> [<c031e773>] do_initcalls+0x2c/0x7a
> [<c01050db>] init+0x58/0x13d
> [<c0105083>] init+0x0/0x13d
> [<c01071f9>] kernel_thread_helper+0x5/0xb
>
>scsi0: Configuring BusLogic Model BT-958 PCI Wide Ultra SCSI Host Adapter
>scsi0:   Firmware Version: 5.07B, I/O Address: 0x1060, IRQ Channel: 17/Level
>scsi0:   PCI Bus: 0, Device: 16, Address: 0xF4000000, Host Adapter SCSI ID: 7
>scsi0:   Parity Checking: Enabled, Extended Translation: Enabled
>scsi0:   Synchronous Negotiation: Ultra, Wide Negotiation: Enabled
>scsi0:   Disconnect/Reconnect: Enabled, Tagged Queuing: Enabled
>scsi0:   Scatter/Gather Limit: 128 of 8192 segments, Mailboxes: 211
>scsi0:   Driver Queue Depth: 211, Host Adapter Queue Depth: 192
>scsi0:   Tagged Queue Depth: Automatic, Untagged Queue Depth: 3
>scsi0:   Error Recovery Strategy: Default, SCSI Bus Reset: Enabled
>scsi0: *** BusLogic BT-958 Initialized Successfully ***
>scsi0 : BusLogic BT-958
>  Vendor: VMware,   Model: VMware Virtual S  Rev: 1.0 
>  Type:   Direct-Access                      ANSI SCSI revision: 02
>SCSI device sda: 12582912 512-byte hdwr sectors (6442 MB)
>sda: asking for cache data failed
>sda: assuming drive cache: write through
>sda: sda1
>
>I have been running my VMMachines for a while now so I dont think theres a 
>huge problem. But should I be worried? Am I just lucky my data hasnt been 
>corrupted by this unsafe mode? Is this being fixed in a future version or 
>2.6? Would you like more debugging info to support this variant of the 
>Buslogic controller better?
>
>Just a curios side-note... what the HECK are mailboxes relating to this scsi 
>driver?! I know what most of the other parameters are, but I cant figure out 
>what a mailbox could be in a scsi driver. 
>
>I am on the LKML, however I prefer to have replies CC'd to me. I notice them 
>MUCH faster.
>-------------------------
>Eric Bambach
>Eric at cisu dot net
>-------------------------
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
