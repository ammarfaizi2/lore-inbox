Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269533AbRHCSFO>; Fri, 3 Aug 2001 14:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269527AbRHCSEy>; Fri, 3 Aug 2001 14:04:54 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:24586 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269533AbRHCSEu>; Fri, 3 Aug 2001 14:04:50 -0400
Date: Fri, 3 Aug 2001 20:04:57 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Paul <pstroud@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mulitple 3c509 cards 2.4.x Kernel
Message-ID: <20010803200457.C31468@emma1.emma.line.org>
Mail-Followup-To: Paul <pstroud@bellsouth.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B6ADBA7.2FC0AE2A@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3B6ADBA7.2FC0AE2A@bellsouth.net>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2001, Paul wrote:

> I have a x86 server with multiple(2) 3c509 cards. When I build the
> 3c509 driver into the kernel. It will only pick up a single card. The
> cards are NOT in pnp mode according to isapnp on boot. I have added:
> 
> append = "ether=3,0x300,0,0,eth0 ether=10,0x280,0,0,eth1"
> 
> to the lilo file and still only one card is detected. The io ports and
> irq's come direct from /proc with  the 2.2.13 kernel in place. There

You should use 2.2.19 nowadays. 2.2.13 is insecure.

Are the cards themselves in ISAPNP mode or in fixed-address/IRQ mode?
Linux 2.4 has ISAPNP capabilities if you choose so at compile time,
these might move the card. Check your boot logs and /proc/isapnp and
/proc/sys/isapnp.

> are no messages about anything failing, only the message that the one
> card was found. It appears the card on the higher io(0x300) is the
> only one that is ever found.

Did you re-run lilo?
