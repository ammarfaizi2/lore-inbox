Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbTIJS3d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265446AbTIJS3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:29:32 -0400
Received: from pop.gmx.de ([213.165.64.20]:51632 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264826AbTIJS3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:29:30 -0400
Message-ID: <3F5F6DE9.3070202@gmx.de>
Date: Wed, 10 Sep 2003 20:31:05 +0200
From: Andreas Schaufler <andreas.schaufler@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: how to find out address of gateway if ip packet's destination is
 outside of the current network ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I just posted this to linux-net, but this list seems to be down. This I 
post it again in here hoping that it is not to much off topic.

I am currently porting a  backplane networking system to Linux which 
shall be able to do IP over PCI,CPCI, VME etc.

Therefore i am currently developing a Linux network driver which is 
using some lower level comminications API in order to transport IP 
packets between several CPU boards (PPC), which are connected through 
the busses mentioned above.
The system is using an internal replacemant for ARP.  It is looking for 
the destination address in the IP header and looking up the destination 
CPU in some internal table where every CPU is accociated with an IP 
address. Afterwards the IP packet is sent to this CPU and there it is 
put into the IP Stack.

My problem is: If the destination address is outside of the backplane 
networking system (some CPU boards can have ethernet plugs) I need to 
find out the gateway, which will send the packet to the outside network. 
I guessed I could get this information out of void *daddr in the 
hard_header function of the net device, but I was not successfull. Is 
there a way to solve my problem ?

thank you very much for your answers in advance
best regards
-Andreas

