Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266947AbRGKXH0>; Wed, 11 Jul 2001 19:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbRGKXHQ>; Wed, 11 Jul 2001 19:07:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46464 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266899AbRGKXHE>;
	Wed, 11 Jul 2001 19:07:04 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15180.56341.731014.82811@pizda.ninka.net>
Date: Wed, 11 Jul 2001 16:07:01 -0700 (PDT)
To: Jes Sorensen <jes@sunsite.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        jgarzik@mandrakesoft.com (Jeff Garzik), bcrl@redhat.com (Ben LaHaise),
        hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)"),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
In-Reply-To: <d3y9pv8ee5.fsf@lxplus015.cern.ch>
In-Reply-To: <3B46FDF1.A38E5BB6@mandrakesoft.com>
	<E15Ir5R-0005lR-00@the-village.bc.nu>
	<15175.2003.773317.101601@pizda.ninka.net>
	<d3y9pv8ee5.fsf@lxplus015.cern.ch>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jes Sorensen writes:
 > The overhead is going be negligeble, the overhead of highmem itself is
 > much worse.

Once Jens's block layer stuff goes in, a lot of that overhead simply
disappears since the page cache need not bounce buffers.  The
networking can already technically cope with this too.

 > Not to mention that today some dma_addr_t's might not be
 > packed properly in data structure hence they ending up taking 8 bytes
 > anyway.

Not on x86 which is the current main benefactor of highmem.

Later,
David S. Miller
davem@redhat.com
