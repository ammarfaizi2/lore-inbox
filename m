Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbRGFXrQ>; Fri, 6 Jul 2001 19:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262058AbRGFXrH>; Fri, 6 Jul 2001 19:47:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48616 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262436AbRGFXqw>;
	Fri, 6 Jul 2001 19:46:52 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15174.19941.681583.314691@pizda.ninka.net>
Date: Fri, 6 Jul 2001 16:46:45 -0700 (PDT)
To: Jes Sorensen <jes@sunsite.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bcrl@redhat.com (Ben LaHaise),
        hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)"),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m achi ne
In-Reply-To: <d3d77ew5dd.fsf@lxplus015.cern.ch>
In-Reply-To: <15164.18270.460245.219060@pizda.ninka.net>
	<E15Fv14-0008TB-00@the-village.bc.nu>
	<15164.59159.645521.383074@pizda.ninka.net>
	<d3pubfw0fi.fsf@lxplus015.cern.ch>
	<15172.64662.696505.761486@pizda.ninka.net>
	<d3d77ew5dd.fsf@lxplus015.cern.ch>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jes Sorensen writes:
 > David> And this still leaves the 64-bit dma_addr_t overhead issue.
 > 
 > The 64 bit dma_addr_t is only an issue on 32 bit architectures with
 > highmem enabled. I never suggested making dma_addr_t 64 bit on 32 bit
 > architectures as a general thing.

What about for drivers of SAC-only devices, they eat the overhead
when highmem is enabled too?

This says nothing about the real reason the IA64 solution is
unacceptable, the inputs to the mapping functions which must
be "page+offset+len" triplets as there is no logical "virtual
address" to pass into the mapping routines on 32-bit systems.

Face it, the ia64 stuff is not what we can use across the board.  It
simply doesn't deal with all the necessary issues.  Therefore,
encouraging driver author's to use this ia64 hacked up scheme is
not such a hot idea until we have a real API implemented.

Later,
David S. Miller
davem@redhat.com
