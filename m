Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIRy4>; Tue, 9 Jan 2001 12:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAIRyq>; Tue, 9 Jan 2001 12:54:46 -0500
Received: from ns.caldera.de ([212.34.180.1]:21772 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129324AbRAIRyc>;
	Tue, 9 Jan 2001 12:54:32 -0500
Date: Tue, 9 Jan 2001 18:53:10 +0100
From: Christoph Hellwig <hch@caldera.de>
To: "Benjamin C.R. LaHaise" <blah@kvack.org>
Cc: Ingo Molnar <mingo@elte.hu>, "Stephen C. Tweedie" <sct@redhat.com>,
        "David S. Miller" <davem@redhat.com>, riel@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010109185310.C15990@caldera.de>
Mail-Followup-To: "Benjamin C.R. LaHaise" <blah@kvack.org>,
	Ingo Molnar <mingo@elte.hu>, "Stephen C. Tweedie" <sct@redhat.com>,
	"David S. Miller" <davem@redhat.com>, riel@conectiva.com.br,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101091547520.4491-100000@e2> <Pine.LNX.3.96.1010109103229.5051A-100000@kanga.kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.3.96.1010109103229.5051A-100000@kanga.kvack.org>; from blah@kvack.org on Tue, Jan 09, 2001 at 10:38:30AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 10:38:30AM -0500, Benjamin C.R. LaHaise wrote:
> What you're completely ignoring is that sendpages is lacking a huge amount
> of functionality that is *needed*.  I can't implement clean async io on
> top of sendpages -- it'll require keeping 1 task around per outstanding
> io, which is exactly the bottleneck we're trying to work around.

Yepp.  That's why I proposed to ue rw_kiovec.  Currently Alexy seems
to have an own hack for socket-only asynch IO with some COW semantics
for the userlevel buffers, but I would much prefer a generic version...

	Christoph

P.S. Any chance to find a new version of your aio-patch somewhere?
-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
