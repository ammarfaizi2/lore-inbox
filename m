Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135885AbREDHat>; Fri, 4 May 2001 03:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135886AbREDHak>; Fri, 4 May 2001 03:30:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24712 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135885AbREDHae>;
	Fri, 4 May 2001 03:30:34 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15090.23187.739430.925103@pizda.ninka.net>
Date: Fri, 4 May 2001 00:30:27 -0700 (PDT)
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: unsigned long ioremap()?
In-Reply-To: <3AF25700.19889930@alsa-project.org>
In-Reply-To: <3AF10E80.63727970@alsa-project.org>
	<Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg>
	<15089.979.650927.634060@pizda.ninka.net>
	<11718.988883128@redhat.com>
	<3AF12B94.60083603@alsa-project.org>
	<15089.63036.52229.489681@pizda.ninka.net>
	<3AF25700.19889930@alsa-project.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Abramo Bagnara writes:
 > it's perfectly fine to have:
 > 
 > regs = (struct reg *) ioremap(addr, size);
 > foo = readl((unsigned long)&regs->bar);
 > 

I don't see how one can find this valid compared to my preference of
just plain readl(&regs->bar); You're telling me it's nicer to have the
butt ugly cast there which serves no purpose?

One could argue btw that structure offsets are less error prone to
code than register offset defines out the wazoo.

I think your argument here is bogus.

Later,
David S. Miller
davem@redhat.com
