Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131400AbRAIOu7>; Tue, 9 Jan 2001 09:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131402AbRAIOuu>; Tue, 9 Jan 2001 09:50:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1036 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131399AbRAIOuq>; Tue, 9 Jan 2001 09:50:46 -0500
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
To: mingo@elte.hu
Date: Tue, 9 Jan 2001 14:51:28 +0000 (GMT)
Cc: sct@redhat.com (Stephen C. Tweedie), riel@conectiva.com.br (Rik van Riel),
        davem@redhat.com (David S. Miller), hch@caldera.de, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101091532150.4368-100000@e2> from "Ingo Molnar" at Jan 09, 2001 03:40:56 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14G07X-0006kT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> designing for them. Eg. if an IO operation (eg. streaming video webcast)
> does a DMA from a camera card to an outgoing networking card, would it be

Most mpeg2 hardware isnt set up for that kind of use. And webcast protocols 
like h.263 tend to be software implemented. 

Capturing raw video for pre-processing is similar. Right now thats best
done with mmap() on the ring buffer and O_DIRECT I/O it seems

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
