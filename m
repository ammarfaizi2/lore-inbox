Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131406AbQLNPJi>; Thu, 14 Dec 2000 10:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131460AbQLNPJ1>; Thu, 14 Dec 2000 10:09:27 -0500
Received: from linux.kappa.ro ([194.102.255.131]:42514 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S131406AbQLNPJT>;
	Thu, 14 Dec 2000 10:09:19 -0500
Date: Thu, 14 Dec 2000 16:38:46 +0200
From: Mircea Damian <dmircea@linux.kappa.ro>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: do NOT compile 2.2.18 with egcs-1.1.2
Message-ID: <20001214163846.A23747@linux.kappa.ro>
In-Reply-To: <20001214102145.B17934@linux.kappa.ro> <E146VXg-00045d-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E146VXg-00045d-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 14, 2000 at 10:23:14AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 10:23:14AM +0000, Alan Cox wrote:
> > I just want to let other know that kernel 2.2.18 does not work properly (*)
> > on my box if I compile it with egcs-2.91.66 19990314/Linux (egcs-1.1.2
> > release). Instead gcc-2.7.2.3 works ok.
> > 
> > (*) the network driver PCI NE2000 does not work with all three cards. It
> > just sees them but they do not work.
> 
> I don't believe that is likely to be the reason. The driver has not changed
> since 2.2.15 if not earlier, and it still seems to work with the cards I have
> here (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)

Then I don't think that I can explain why it works with gcc-2.7.2.3.

My particular setup is:
- 3 PCI NE2000 cards and 1 ISA NE2000 card.


The isa card worked always but from the PCI cards only one worked (I just
ifconfig ethX up; tcpdump -i ethX -nlqt and I see no packets there, I also
see no interrupts from that cards too, so this may be related to pci code).

Anyway, as I said before, with gcc-2.7.2.3 it works fine.


.. ah, and something else: first I had a EtherExpress Pro 10/100 card which
behaved in the same way but I thought I have a bus-mastering problem with
PCI cards so I replaced it.

-- 
Mircea Damian
E-mails: dmircea@kappa.ro, dmircea@roedu.net
WebPage: http://taz.mania.k.ro/~dmircea/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
