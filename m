Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266138AbRGGMS4>; Sat, 7 Jul 2001 08:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266151AbRGGMSr>; Sat, 7 Jul 2001 08:18:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2314 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266138AbRGGMSk>; Sat, 7 Jul 2001 08:18:40 -0400
Subject: Re: Athlon oops traced to CONFIG_MK7 code in arch/i386/lib/mmx.c
To: cshihpin@dso.org.sg (Richard Chan)
Date: Sat, 7 Jul 2001 13:19:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
In-Reply-To: <20010707091046.A2355@cshihpin.dso.org.sg> from "Richard Chan" at Jul 07, 2001 09:10:46 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Ir36-0005l7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm interested if there is an explanation of the MK7 specific code in mmx.c and
> whether that could really be the source of the problem. I would like to get
> to the bottom of this.

As far as we can tell the problem is 'using a VIA chipset'. The code itself
is a fast copying loop using mmx/3dnow/amd athlon extended mmx stuff

Pick up an Athlon documentation set (pdf on the web site) and you should be
able to follow it. prefetch does what you'd expect, sfence is a store fence
for non temporal stores (ie out of order stuff) amd movntq is an out of order
move

> FWIW - the RedHat 7.1 stock 2.4.2 athlon kernel boots successfully without oopsen.

That doesn't have CONFIG_MK7k
