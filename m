Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265801AbRGKTSG>; Wed, 11 Jul 2001 15:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265024AbRGKTR4>; Wed, 11 Jul 2001 15:17:56 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:55556 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S265005AbRGKTRm>;
	Wed, 11 Jul 2001 15:17:42 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        jgarzik@mandrakesoft.com (Jeff Garzik), bcrl@redhat.com (Ben LaHaise),
        hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)"),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
In-Reply-To: <3B46FDF1.A38E5BB6@mandrakesoft.com> <E15Ir5R-0005lR-00@the-village.bc.nu> <15175.2003.773317.101601@pizda.ninka.net>
From: Jes Sorensen <jes@sunsite.dk>
Date: 11 Jul 2001 21:16:50 +0200
In-Reply-To: "David S. Miller"'s message of "Sat, 7 Jul 2001 06:00:03 -0700 (PDT)"
Message-ID: <d3y9pv8ee5.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David> Alan Cox writes:
>> I see no good way to optimise for 64bit dma on a 32bit box.

David> I'm actually not only talking about DAC device on 32-bit cpus.
David> Just as much, I'm talking about drivers for SAC-only devices
David> even on 64-bit cpus.

David> I took a lot of crap from driver authors when we started
David> pushing the PCI dma stuff on people, because of the dma_addr_t
David> people now had to keep around to unmap the thing later.

David> To a certain extent I agreed with these folks.  I'll be gutting
David> myself if I make everyone eat twice as much space just to add
David> DAC support to the kernel :-)

The overhead is going be negligeble, the overhead of highmem itself is
much worse. Not to mention that today some dma_addr_t's might not be
packed properly in data structure hence they ending up taking 8 bytes
anyway.

Jes
