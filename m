Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTFPQFp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 12:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTFPQFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 12:05:45 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:44751 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263922AbTFPQFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 12:05:44 -0400
Message-ID: <3EEDEDA1.7010401@us.ibm.com>
Date: Mon, 16 Jun 2003 09:17:37 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herman Dierks <hdierks@us.ibm.com>
CC: "David S. Miller" <davem@redhat.com>, ltd@cisco.com, anton@samba.org,
       haveblue@us.ibm.com, scott.feldman@intel.com, dwg@au1.ibm.com,
       linux-kernel@vger.kernel.org, Nancy J Milliner <milliner@us.ibm.com>,
       Ricardo C Gonzalez <ricardoz@us.ibm.com>,
       Brian Twichell <twichell@us.ibm.com>, netdev@oss.sgi.com
Subject: Re: e1000 performance hack for ppc64 (Power4)
References: <OF7D02DC37.06BCABE8-ON85256D46.004E9127@pok.ibm.com>
In-Reply-To: <OF7D02DC37.06BCABE8-ON85256D46.004E9127@pok.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herman Dierks wrote:
> Look folks,   we run 40 to 48  GigE adapters in a p690 32 way on AIX and
> they basically all run at full speed  so let me se you try that on most of
> these other boxes you are talking about.     Same adapter, same hardware
> logic.

FWIW, I think that's pretty cool. Not easy to do. :)

> For larger packets, like jumbo frames or large send (TSO), the few added
> DMA's is not an issue as the packets are so large the DMA soon get aligned
> and are not an issue.   With TSO being the default,   the small packet case
> becomes less important anyway.   Its more an issue on 2.4 where TSO is not
> provided.  We also want this to run well if someone does not want to use
> TSO.

Slightly off-topic, but TSO being enabled and TSO being used are
two different things, right? Ditto jumbo frames..How often is this
the actual env in real world situations? I'm concerned that this
is more typical of development testing/performance testing
environments.

> Its only the MTU 1500 case with non-TSO that we are discussing here so

Which still is the pretty important case, I think..

> copying a few bytes is really not a big deal as the data is already in
> cache from copying into kernel.  If it lets the adapter run at speed, thats
> what customers want and what we need.

Yep.

> Granted, if the HW could deal with this we would not have to, but thats not
> the case today so I want to spend a few CPU cycles to get best performance.
> Again, if this is not done on other platforms, I don't understand why you
> care.

Still would be nice to put in the best solution possible, i.e.
address it for the broadest set of affected pieces and minimizing
the impact..

> If we have to do this for PPC port, fine.   I have not seen any of you

Hope it doesn't have to come to that..It would be nice to
see it in the mainline kernel. Regardless of platform, distro, etc..
these users are still people who are taking the time, the effort to
adopt Linux and sometimes in environments and situations that are
pretty critical. Change and innovation are difficult activities
to engage in some places, and anything we can do to make this
a no-brainer solution for them, and their decisions shine, thats
gotta be worth something to go the extra mile for :)

thanks,
Nivedita


