Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287850AbSAFMvD>; Sun, 6 Jan 2002 07:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSAFMut>; Sun, 6 Jan 2002 07:50:49 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:29709 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S288787AbSAFMue>;
	Sun, 6 Jan 2002 07:50:34 -0500
Date: Sun, 6 Jan 2002 23:49:27 +1100
From: Anton Blanchard <anton@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: O(1) scheduler, 2.5.2-pre9-B1 results
Message-ID: <20020106124927.GA30292@krispykreme>
In-Reply-To: <Pine.LNX.4.33.0201060128250.1250-100000@localhost.localdomain> <Pine.LNX.4.33.0201060202590.2102-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201060202590.2102-100000@localhost.localdomain>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo,

I got your scheduler rewrite going on ppc64. Here are some initial
LMbench results with sched-O1-2.4.17-B4.patch. Bear in mind the two
machines are different chips (one is Power3 and the other is RS64), so
some differences will result:

2 way (POWER3) summary:
signal handling down a bit (GOOD)
fork down a lot (very GOOD)
exec, sh down (GOOD)
context switches all down (GOOD)
communication latencies: Pipe, AF, TCP slightly up (BAD)
pipe bandwidth up (GOOD)

4 way (RS64) summary:
stat up a bit (BAD)
fork down a lot (very GOOD)
exec, sh down (GOOD)
context switches same or down (GOOD)
communication latencies: Pipe, AF, TCP slightly up (BAD)
pipe bandwidth up (GOOD)

So far things look good. Next up I'll look at how it scales on the 12
way.

Anton
