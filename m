Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269970AbRHJSqq>; Fri, 10 Aug 2001 14:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269972AbRHJSqh>; Fri, 10 Aug 2001 14:46:37 -0400
Received: from zero.aec.at ([195.3.98.22]:59402 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S269970AbRHJSqW>;
	Fri, 10 Aug 2001 14:46:22 -0400
To: subba9@home.com (Subba Rao)
cc: linux-kernel@vger.kernel.org
Subject: Re: Half Duplex and Zero Copy IP
In-Reply-To: <20010810095313.A6219@home.com>
From: Andi Kleen <ak@muc.de>
Date: 10 Aug 2001 20:46:31 +0200
In-Reply-To: subba9@home.com's message of "Fri, 10 Aug 2001 13:53:56 +0000 (UTC)"
Message-ID: <k266bveos8.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010810095313.A6219@home.com>,
subba9@home.com (Subba Rao) writes:
> Hello,
> I have 2 3Com NICs on my system. They are 3c905C Tornado PCI cards.
> The drivers are compiled into the kernel (Slackware 8.0 with kernel 2.4.7).

> One of the interfaces will be used as a sniffer interface (without IP address)
> and a very high traffic pipes. I do not wish to loose any packets coming to this
> interface. Is it better if I initialize the interface in HALF DUPLEX mode? If yes,
> how do I set the card to HALF DUPLEX mode? How can I find out the HW (NIC) settings
> on the system?

Half duplex mode will only make your line slower, it has no benefit.

> Another question about 3Com NICs, do they perform zero-copy IP? I read that
> the performance improves a lot WITHOUT zero-copy IP.

The sniffer zero copy implementation as implemented in some libpcaps 
does not depend on any special NIC support; it should work with any.

-Andi
