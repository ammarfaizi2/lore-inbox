Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129193AbRBTElJ>; Mon, 19 Feb 2001 23:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129535AbRBTEkt>; Mon, 19 Feb 2001 23:40:49 -0500
Received: from server.divms.uiowa.edu ([128.255.28.165]:4612 "EHLO
	server.divms.uiowa.edu") by vger.kernel.org with ESMTP
	id <S129193AbRBTEkj>; Mon, 19 Feb 2001 23:40:39 -0500
From: Doug Siebert <dsiebert@divms.uiowa.edu>
Message-Id: <200102200440.WAA10118@server.divms.uiowa.edu>
Subject: Re: PROBLEM: pci bridge fails to wake up from suspend/resume( Inspiron 8000 )
To: nfp3033@privat.cybercity.no
Date: Mon, 19 Feb 2001 22:40:31 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morten,

I'm not subscribed to linux-kernel, but I've been following the list archive
somewhat for the past month (watching 2.4 development so I can figure out
when it is safe to make the jump without too much hassle)

I just bought a Dell Inspiron 4000 laptop a month ago, and have the same
problem with suspend/resume, with both devices on the PCI bridge (both the
eepro100 ethernet as well as the LT winmodem) Same symptoms, both work fine
until suspend, after resume neither work at all.  I tried your fix, and it
worked for me.  I did the same thing you did, running 'lspci -vx' to see
the PCI registers before and after, and then use 'setpci' to fix them.
Since the i4000 uses a 440BX mobile chipset, it isn't exactly the same
commands, but I got it to work (I had to ifconfig eth0 down then 'ifup
eth0' to make it work)  Its a pretty general fix, as I'm running Redhat 6.2
with kernel 2.2.16.  Yeah, kind of old, but I hope to be running 2.4 pretty
soon!  (BTW, as you probably already know, your fix works fine for
re-enabling the winmodem after resume as well)

I'm cc:ing linux-kernel also, in case anyone working this problem can benefit
from the additional data point.  If anyone working this needs further info
from me (lspci results or whatever) feel free to email me at this address.

-- 
Douglas Siebert
douglas-siebert@uiowa.edu

A computer without Microsoft software is like chocolate cake without ketchup.
