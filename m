Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSDCJN0>; Wed, 3 Apr 2002 04:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293541AbSDCJNR>; Wed, 3 Apr 2002 04:13:17 -0500
Received: from pop.gmx.net ([213.165.64.20]:60355 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293510AbSDCJNI>;
	Wed, 3 Apr 2002 04:13:08 -0500
Date: Wed, 3 Apr 2002 18:41:02 +0930
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel panic, "Aiee, killing interrupt handler!"
Message-ID: <20020403091102.GA1492@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Daniel Mundy <djmunds@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lately I have had my box freeze up just after connecting, although it
doesn't happen every time.. I am not sure exactly what the factors are
that make it crash. 

When I was having the freezes yesterday I watched syslog from a terminal
and wrote down some of the output on paper (I did a search in my syslog
file just now and it I don't have any of this... maybe because the data
was still in cache and didn't get written to disk?):

--
PPP BSD Compresseion module registered
PPP Deflate Compression module registered
Unable to handle kernel paging requestat virtual address 010000a
  printing eip:
010000a
*pde = 00000000
Oops: 0000
CPU: 0
EIP
--

...this is where I stopped writing, was further debugging messages. They
would have been no use to me but at the time I wasn't considering
writing to this list, now I am thinking maybe they would have been
useful... I got a bit more of the messages though:

--
Code: Bad EIP value.
<0>Kernel panicL Aiee, killing interrupt handler!
In interrupt handler - not syncing
--

I also noticed a weird startup message, although I have no idea whether
this is related:

--
/etc/init.d/rc: line 6: 180 Segmentation fault $debug "$@"
--

One other message I see in syslog a few times, and also am not sure
whether it is related:

--
pppd[357]: Cannot determine ethernet address for proxy ARP
--

Has anyone had similar problems? I asked around a bit on IRC and I was
recommended to try asking on this list.

Regards,
Daniel Mundy
