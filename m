Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132059AbRADA00>; Wed, 3 Jan 2001 19:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132109AbRADA0G>; Wed, 3 Jan 2001 19:26:06 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:33293 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S132059AbRADA0E>;
	Wed, 3 Jan 2001 19:26:04 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101040025.f040Pg8412936@saturn.cs.uml.edu>
Subject: Re: RFC: /xproc -> /proc files in xml grammer?
To: kpierre@fit.edu (Kervin Pierre)
Date: Wed, 3 Jan 2001 19:25:42 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A53B08D.F10B96FB@fit.edu> from "Kervin Pierre" at Jan 03, 2001 06:06:53 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would XML be considered human readable enough for /proc files?  If not,
> how about a /xproc filesystem ( maybe as a kernel build option ), same
> as /proc but uses an xml grammer for reporting.
> I can see tons of uses for this, no more 'fuzzy' parsing for gui
> configuration tools, resource monitors, etc.

No.

No XML. No colons. No newlines. No embedded whitespace.
No quoting. No field names. No other screwing around.

Option 1 looks like this:    42 8842 0 4234 898 33 221 2512

Option 2 is a raw array of 64-bit binary data

Anything else, and somebody like you will be tempted to muck with it.
We've seen spelling changes and column alignment break things. We've
seen parsers break on /proc/cpuinfo because someone decided whitespace
and extra columns might be nice. XML wouldn't be immune to the recent
"features" vs. "flags" problem, but the two options above are.

Now, what is your problem? Grab libgtop (GPL) or libproc (LGPL) and
be happy. All of "ps" is in fact under the LGPL, so you can grab
anything else you might need. (LGPL: not just for libraries anymore)

You get libproc and ps here:  http://www.cs.uml.edu/~acahalan/procps/
(maybe wait a week or two before you grab that -- new one coming)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
