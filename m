Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131817AbRCUXSO>; Wed, 21 Mar 2001 18:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131818AbRCUXRz>; Wed, 21 Mar 2001 18:17:55 -0500
Received: from cpe.atm0-0-0-180310.boanxx4.customer.tele.dk ([62.243.2.100]:6064
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S131817AbRCUXRp>; Wed, 21 Mar 2001 18:17:45 -0500
Message-ID: <3AB9366E.3060905@fugmann.dhs.org>
Date: Thu, 22 Mar 2001 00:17:02 +0100
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8.1) Gecko/20010314
X-Accept-Language: en
MIME-Version: 1.0
To: Jerome Tollet <Jerome.Tollet@qosmos.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.2 network performances
In-Reply-To: <3AB08FAC.657784CA@qosmos.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome.

As Mr. Hafting says, is seems that there is a softirq missing somewhere.
If this is the case, it should help to make some add some systemcalls in 
your program, since a softirq should happen at every system-call exit.

Try adding:

	getpid();

in the innermost loop, and see if it helps.

I would be happy to look deeper into it, so if you could send me your 
test program and I'll see if I can find anything. Please append the 
result from the code with and without the getpid call.


Regards
Anders Fugmann

-- 
Hi. I'm a .signature virus.
Please copy me into your .signature file and help me spread.

