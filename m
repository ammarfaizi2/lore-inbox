Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132259AbQL1LwV>; Thu, 28 Dec 2000 06:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132238AbQL1LwL>; Thu, 28 Dec 2000 06:52:11 -0500
Received: from colorfullife.com ([216.156.138.34]:42513 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132126AbQL1LwC>;
	Thu, 28 Dec 2000 06:52:02 -0500
Message-ID: <3A4B234E.7A950A76@colorfullife.com>
Date: Thu, 28 Dec 2000 12:26:06 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: david@linux.com, linux-kernel@vger.kernel.org
Subject: Re: NETDEV WATCHDOG: eth0: transmit timed out
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David wrote:
>
> Same old story, bugger still does it. Have to set the link down/up to 
> get it running again. 
>
> 00:12.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 
> 20) 
>

I missed your earlier mails, could you resend the details? 
I'm interested in the output from

	tulip-diag -m -a -f

before and after a link failure.


I'm aware that the tulip drivers doesn't handle cable disconnects and
reconnects with MII pnic cards. I have a patch for that problem, but it
affects _all_ MII tulip cards, and thus it won't be included soon. If
tulip-diag says "10mbps-serial", then you have run into that bug.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
