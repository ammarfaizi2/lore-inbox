Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUBXUj4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbUBXUiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:38:10 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:62938 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262453AbUBXUg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:36:56 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Tue, 24 Feb 2004 20:36:53 -0000
MIME-Version: 1.0
Subject: Re: 2.6.3 RT8139too NIC problems
Message-ID: <403BB5E5.17054.156978FE@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Funnily enough, I looked at this at work today and decided to check 
> against 8139too.c from 2.6.2 and 2.6.3 trees.  There was a lot of 
> changes, but it appeared only to that file (i.e. nothing referencing 
> it) - so I have just built 2.6.3 with the 8139too.c source from 2.6.2 
> just to make sure it isn't code elsewhere (i.e. pci stuff?) that is 
> causing it.
> 
> So far it is running perfectly.  I will wait a while to test, and if 
> it doesn't show any problems, we can presume it is the changes that 
> caused this problem for me on my system.
> 
> Enquiries to the HantsLUG seem to be that no-one else gets this 
> problem.

This has solved the problem for me.  Please can anyone tell me what 
details are required to provide a bug report on this strange one off 
issue, as I wouldn't know where to start.

To recap:

rtl8139too cards worked on all kernels up until 2.6.3 (like 3 years).

The timeout issues started with 2.6.3 (using make oldconfig)... new 
settings applied.

Tried lilo 'append="noapic"  -> problem still persisted.

After reading I changed: 2.6.2 source-> 8139too.c to replace new 
2.6.3 source-> 8139too.c -> rebuilt with same .config.  No timeouts - 
all hunky dory.

Thanks,

Nick

[root@Linux233 log]# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C585VP [Apollo 
VP1/VPX] (rev 23)
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA 
[Apollo VP] (rev 27)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)


-- 
"When you're chewing on life's gristle,
Don't grumble,
Give a whistle
And this'll help things turn out for the best."

