Return-Path: <linux-kernel-owner+w=401wt.eu-S965044AbXATAio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbXATAio (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 19:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbXATAio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 19:38:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:41815 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965032AbXATAin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 19:38:43 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,213,1167638400"; 
   d="scan'208"; a="187047900:sNHT22019963"
Message-ID: <45B16491.7030207@intel.com>
Date: Fri, 19 Jan 2007 16:38:41 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.9 (X11/20061228)
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: Allen Parker <parker@isohunt.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: intel 82571EB gigabit fails to see link on 2.6.20-rc5 in-tree
 e1000 driver (regression)
References: <20070117190448.A20184@mail.kroptech.com> <45AEB79B.2010205@intel.com> <00d701c73c1f$b2bb2390$84163e05@kroptech.com> <45B1562C.8070503@intel.com> <011101c73c29$9f6f5db0$84163e05@kroptech.com>
In-Reply-To: <011101c73c29$9f6f5db0$84163e05@kroptech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jan 2007 00:38:42.0981 (UTC) FILETIME=[56240550:01C73C2B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> Auke Kok wrote:
>> Adam Kropelin wrote:
>>> I haven't been able to test rc5-mm yet because it won't boot on this
>>> box. Applying git-e1000 directly to -rc4 or -rc5 results in a number
>>> of rejects that I'm not sure how to fix. Some are obvious, but the
>>> others I'm unsure of.
>>
>> that won't work. You either need to start with 2.6.20-rc5 (and pull
>> the changes pending merge in netdev-2.6 from Jeff Garzik),
> 
> I thought that's what I was doing when I applied git-e1000 to 
> 2.6.20-rc5, but I guess not.
> 
>> or start
>> with 2.6.20-rc4-mm1 and manually apply that patch I sent out on
>> monday. A different combination of either of these two will not work,
>> as they are completely different drivers.
> 
> I'll try to work something out.
> 
>> can you include `ethtool ethX` output of the link down message and
>> `ethtool -d ethX` as well? I'll need to dig up an 82572 and see
>> what's up with that, I've not seen that problem before.
> 
> ethtool output attached.

that clearly shows that the PHY detected link up status and that all is well as far as 
the driver and NIC is concerned. This bug really needs to be moved to linux-pci where 
the folks who know interrupt handling best can handle it.

Auke
