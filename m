Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129253AbQKGH7a>; Tue, 7 Nov 2000 02:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbQKGH7T>; Tue, 7 Nov 2000 02:59:19 -0500
Received: from atlantis.hlfl.org ([213.41.91.231]:9476 "HELO atlantis.hlfl.org")
	by vger.kernel.org with SMTP id <S129352AbQKGH7M>;
	Tue, 7 Nov 2000 02:59:12 -0500
Date: Tue, 7 Nov 2000 08:59:11 +0100
From: "Arnaud S . Launay" <asl@launay.org>
To: Andries Brouwer <aeb@veritas.com>
Cc: aprasad@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: processes> 2^15
Message-ID: <20001107085911.A2546@profile4u.com>
Mail-Followup-To: Andries Brouwer <aeb@veritas.com>, aprasad@in.ibm.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <CA25698D.00608C13.00@d73mta05.au.ibm.com> <20001104210158.A13496@veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001104210158.A13496@veritas.com>; from aeb@veritas.com on Sat, Nov 04, 2000 at 09:01:58PM +0100
X-PGP-Key: http://launay.org/pgpkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, Nov 04, 2000 at 09:01:58PM +0100, Andries Brouwer a écrit:
> > after reaching process count something around 30568, processes start
> > getting pid from start, which ever is the first free entry slot in process
> > table. that means we can't have simultaneously more than roughly 2^15
> > processes?
> > am i correct?
> 
> Yes.
> (If that displeases you I can give you the trivial patch.
> However, you really need some awesome machine before it
> becomes reasonable to run that many processes.)

In the fact, the first limit to be reached will be NR_TASKS defined in
linux/tasks.h:
#define NR_TASKS        512     /* On x86 Max 4092, or 4090 w/APM configured. */

So I wonder if we could really have more than 4092 process under x86 ?

	Arnaud.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
