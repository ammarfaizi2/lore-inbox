Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVCXTik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVCXTik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 14:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbVCXTik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 14:38:40 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:21139 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261718AbVCXTia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 14:38:30 -0500
Message-ID: <42431734.3030905@candelatech.com>
Date: Thu, 24 Mar 2005 11:38:28 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: PCI interrupt problem: e1000 & Super-Micro X6DVA motherboard
References: <42421FF2.7050501@candelatech.com> <20050324081003.GA23453@xi.wantstofly.org>
In-Reply-To: <20050324081003.GA23453@xi.wantstofly.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennert Buytenhek wrote:
> On Wed, Mar 23, 2005 at 06:03:30PM -0800, Ben Greear wrote:
> 
> 
>>I have two 4-port e1000 NICs in the system, on a riser card.
> 
> 
> How is the riser card wired?  F.e. does it have a single edge
> connector, and provides two PCI slots, or does it have a tiny
> additional edge connector that routes REQ#/GNT#/INTx from a
> nearby PCI slot, etc.?

I was able to reproduce the problem even when the 4-port e1000 NIC
is plugged directly into the motherboard, so it's not the
riser...

I also tried with a 4-port VIA-Rhine NIC (router-board 44).  It also
fails it's third interface, with the same problem.  So, it is not
the e1000 NIC nor the e1000 driver that is the problem.

I do notice that it is the same interrupt (26) that is always assigned
to the broken port.  I have the lspci and dmesg output for the via-rhine
boot if anyone wants it...

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

