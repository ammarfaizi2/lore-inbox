Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269045AbTBXAXz>; Sun, 23 Feb 2003 19:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269046AbTBXAXz>; Sun, 23 Feb 2003 19:23:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2820 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269045AbTBXAXy>; Sun, 23 Feb 2003 19:23:54 -0500
Date: Sun, 23 Feb 2003 16:31:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: pte-highmem vs UKVA (was: object-based rmap and pte-highmem)
In-Reply-To: <20030223221030.GK10411@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0302231628510.1690-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Feb 2003, William Lee Irwin III wrote:
> 
> Another term for "UKVA for pagetables only" is "recursive pagetables",
> if this helps clarify anything.

Oh, ok. We did that for alpha, and it was a good deal there (it's actually
architected for alpha). So yes, I don't mind doing it for the page tables,
and it should work fine on x86 too (it's not necessarily a very portable
approach, since it requires that the pmd- and the pte- tables look the
same, which is not always true).

So sure, go ahead with that part.

		Linus

