Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135264AbREDAW7>; Thu, 3 May 2001 20:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135508AbREDAWj>; Thu, 3 May 2001 20:22:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56453 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135264AbREDAWa>;
	Thu, 3 May 2001 20:22:30 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15089.63036.52229.489681@pizda.ninka.net>
Date: Thu, 3 May 2001 17:22:20 -0700 (PDT)
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: unsigned long ioremap()?
In-Reply-To: <3AF12B94.60083603@alsa-project.org>
In-Reply-To: <3AF10E80.63727970@alsa-project.org>
	<Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg>
	<15089.979.650927.634060@pizda.ninka.net>
	<11718.988883128@redhat.com>
	<3AF12B94.60083603@alsa-project.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Abramo Bagnara writes:
 > IMO this is a far less effective debugging strategy.

I agree with you.

But guess what driver authors are going to do?  They are going to cast
the thing left and right.  And sure you can then search for that, but
it isn't likely to make people fix this from the start.

I suppose the point is that there is a fine line wrt. using APIs to
influence people to "do the right thing", and this has been
exemplified in several threads I've been involved in wrt. PCI dma
and other topics. :-)

One final point, I want to reiterate that I believe:

	foo = readl(&regs->bar);

is perfectly legal and should not be discouraged and in particular,
not made painful to do.

Later,
David S. Miller
davem@redhat.com

