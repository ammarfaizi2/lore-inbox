Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129472AbQJ0BP6>; Thu, 26 Oct 2000 21:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130085AbQJ0BPs>; Thu, 26 Oct 2000 21:15:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5204 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129472AbQJ0BPi>; Thu, 26 Oct 2000 21:15:38 -0400
Subject: Re: missing mxcsr initialization
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 27 Oct 2000 02:15:41 +0100 (BST)
Cc: dledford@redhat.com (Doug Ledford),
        torvalds@transmeta.com (Linus Torvalds),
        paubert@iram.es (Gabriel Paubert), mingo@redhat.com,
        gareth@valinux.com, linux-kernel@vger.kernel.org
In-Reply-To: <20001026021731.B23895@athlon.random> from "Andrea Arcangeli" at Oct 26, 2000 02:17:31 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13oy7T-00043v-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > corrected for include the facts that the XMM feature bit is an Intel specific
> > bit that other vendors may use for other things, so you need to test vendor ==
> 			 ^^^
> Note that they shouldn't do that! I would consider a very bad thing if they
> goes out of sync on those bits.

CPUID is vendor specific. Every bit in those fields is vendor specific. Every
piece of documentation tells you to check the CPU vendor.  Every time we didnt 
bother we got burned.

I keep hearing people saying things like 'bad thing' 'assume standards'. Well
all I can say is cite a vendor issued document which says 'dont bother checking
the vendor'. 

And when you can't find that document, put the checks in so we dont crash on
an Athlon or when using MTRR on a Cyrix III etc

Alan



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
