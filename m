Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130303AbRCBC2e>; Thu, 1 Mar 2001 21:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130292AbRCBC20>; Thu, 1 Mar 2001 21:28:26 -0500
Received: from pizda.ninka.net ([216.101.162.242]:772 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130290AbRCBC2O>;
	Thu, 1 Mar 2001 21:28:14 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15007.825.483003.106274@pizda.ninka.net>
Date: Thu, 1 Mar 2001 18:19:37 -0800 (PST)
To: Grant Grundler <grundler@cup.hp.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: Re: The IO problem on multiple PCI busses
In-Reply-To: <200103020122.RAA28985@milano.cup.hp.com>
In-Reply-To: <200103020122.RAA28985@milano.cup.hp.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Grant Grundler writes:
 > A nice side effect of this bloat is it will discourage use of I/O
 > Port space. That's good for everyone, AFAICT. (I know some devices
 > *only* support I/O port space and I personnally don't care about
 > them. If someone who does care about one wants to talk to me about
 > it...fine...I'll help)

There is another case you are ignoring.  Some devices support memory
space as well as I/O space, but only operate reliably when their
I/O space window is used to access it.

It just sounds to me like the hppa pci controllers are crap,
especially the GSC one.  At least the rope one does something
reasonable when you have a 64-bit kernel.  The horrors you've told me
about the IOMMUs and stream-caches on these chips further confirms my
theory :-)

Later,
David S. Miller
davem@redhat.com
