Return-Path: <linux-kernel-owner+w=401wt.eu-S1947757AbWLIBpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947757AbWLIBpo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 20:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947749AbWLIBpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 20:45:44 -0500
Received: from www.nabble.com ([72.21.53.35]:56569 "EHLO talk.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947757AbWLIBpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 20:45:42 -0500
Message-ID: <7768447.post@talk.nabble.com>
Date: Fri, 8 Dec 2006 17:45:41 -0800 (PST)
From: Vasco <vvisser@science.uva.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] atl1: Revised Attansic L1 ethernet driver
In-Reply-To: <4568EEE5.3080301@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: vvisser@science.uva.nl
References: <20061119202817.GA29736@osprey.hogchain.net> <20061121202541.GA23036@dreamland.darkstar.lan> <20061125224358.GA29403@dreamland.darkstar.lan> <4568EEE5.3080301@bellsouth.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've got the p5B-E board to with the onboard attansic l1.

I did the the atl1-2.0.2 patch against the 2.6.19.rc6 kernel.

I can confirm the card is working but performance is *really* bad, 200Kb/s
over Gbit LAN.
I tried copying a ~50MB file over SSH and it didn't complete because of a
connection stall.

I also tried turninig off TSO as adviced, but i got the message "operation
not supported". 

Im willing to do more testing, just tell me what I can do.

Greetings
Vasco


Jay Cliburn wrote:
> 
> Luca Tettamanti wrote:
> 
>> Got the board, done some basic testing: so far so good :)
>> 
>> The controller also supports MSI and (at least with my chipset - G965)
>> it works fine:
>> 
>> 218:      80649          0   PCI-MSI-edge      eth1
>> 
>> which is nice, otherwise it ends up sharing the IRQ with SATA and USB.
>> 
>> I also have a small patch:
> 
> Thanks for the patch.  We'll add it for the next version.
> 
> FYI, TSO performance is _really_ bad; your tx speed will drop dramatically
> with 
> TSO on (and it's on by default).  I haven't yet been able to find the
> problem. 
> If you want to improve tx performance, turn off TSO with ethtool.
> 
> Jay
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
View this message in context: http://www.nabble.com/-PATCH-0-4--atl1%3A-Revised-Attansic-L1-ethernet-driver-tf2665327.html#a7768447
Sent from the linux-kernel mailing list archive at Nabble.com.

