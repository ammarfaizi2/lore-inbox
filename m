Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJDF7>; Tue, 9 Jan 2001 22:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130475AbRAJDFj>; Tue, 9 Jan 2001 22:05:39 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3857 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129431AbRAJDFc>; Tue, 9 Jan 2001 22:05:32 -0500
Subject: Re: storage over IP (was Re: [PLEASE-TESTME] Zerocopy networking patch,
To: dean-list-linux-kernel@arctic.org (dean gaudet)
Date: Wed, 10 Jan 2001 03:05:45 +0000 (GMT)
Cc: mingo@elte.hu (Ingo Molnar), riel@conectiva.com.br (Rik van Riel),
        davem@redhat.com (David S. Miller), hch@caldera.de, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101091826200.10428-100000@twinlark.arctic.org> from "dean gaudet" at Jan 09, 2001 06:56:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GBa7-00081t-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fixed length headers).  i've never investigated the actual protocols
> though so maybe the solution used was to just push a lot of the detail
> down into the controllers.

The stuff I have access to (MPT fusion) pushes the FC handling down onto the
board. Basically you talk scsi and IP to it (See drivers/message/fusion in
-ac)

> <http://www.ietf.org/internet-drafts/draft-ietf-ips-fcovertcpip-01.txt>
> show that both use TCP/IP.  TCP/IP has variable length headers (or am i on
> crack?), which totally complicates the receive path.

TCP has variable length headers. It also prevents you re-ordering commands
in the stream which would be beneficial. I've not checked if the draft uses
multiple TCP streams but then you have scaling questions. 

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
