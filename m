Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132521AbRDQRPJ>; Tue, 17 Apr 2001 13:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132767AbRDQRO7>; Tue, 17 Apr 2001 13:14:59 -0400
Received: from [212.90.202.121] ([212.90.202.121]:57848 "HELO
	toe.terreactive.ch") by vger.kernel.org with SMTP
	id <S132521AbRDQROp>; Tue, 17 Apr 2001 13:14:45 -0400
Message-ID: <3ADC798E.35236DBE@tac.ch>
Date: Tue, 17 Apr 2001 19:12:46 +0200
From: Roberto Nibali <ratz@tac.ch>
Organization: terreActive
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en, de-CH, zh-CN
MIME-Version: 1.0
To: Steve Hill <steve@navaho.co.uk>
CC: linux-kernel@vger.kernel.org, Donald Becker <becker@scyld.com>
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <Pine.LNX.4.21.0104171727300.4446-100000@sorbus.navaho>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have no idea - I haven't been able to get in touch with him :(
> (The fix was urgently required, and this did the job).

I just realized I had this old patch for 2.2.17 and that in 2.2.19
series this problem is addressed correctly by Donald. Apologies to
him and sorry about the confusion. His or Ion's code from the starfire.c:

int __init starfire_probe(struct net_device *dev)
{
        static int __initdata probed = 0;

        if (probed)
                return -ENODEV;
        probed++;

        return pci_module_init(&starfire_driver);
}

> Not sure - I've never tried initing more than 3 of the DP83815 cards in a
> single machine.  (I am using Cobalt Qube 3's, which have 2 DP83815's on
> the motherboard, and a single PCI slot which I have installed a DP38315 in
> for testing purposes).

I think this is not the problem of the driver specifically but more of the
limitation of Space.c. I haven't yet found a clean way around it. I always
get "early initialization of device eth14 is deferred" messages.

Regards,
Roberto Nibali, ratz

-- 
mailto: `echo NrOatSz@tPacA.cMh | sed 's/[NOSPAM]//g'`
