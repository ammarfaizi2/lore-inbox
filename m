Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130464AbRAIPiO>; Tue, 9 Jan 2001 10:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131153AbRAIPiE>; Tue, 9 Jan 2001 10:38:04 -0500
Received: from chiara.elte.hu ([157.181.150.200]:15116 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130464AbRAIPhw>;
	Tue, 9 Jan 2001 10:37:52 -0500
Date: Tue, 9 Jan 2001 16:37:26 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Rik van Riel <riel@conectiva.com.br>, "David S. Miller" <davem@redhat.com>,
        <hch@caldera.de>, <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <20010109151725.D9321@redhat.com>
Message-ID: <Pine.LNX.4.30.0101091621540.4491-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Stephen C. Tweedie wrote:

> Jes has also got hard numbers for the performance advantages of
> jumbograms on some of the networks he's been using, and you ain't
> going to get udp jumbograms through a page-by-page API, ever.

i know the performance advantages of jumbograms (typically when it's over
a local network), it's undisputed. Still i dont see why it should be
impossible to do effective UDP via a single-page interface. Eg. buffering
of outgoing pages could be supported, and MSG_MORE in sendmsg() used to
indicate end of stream. This is why ->writepage() has a 'more' flag (and
tcp_sendpage() has a flag as well).

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
