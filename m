Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRAJCT0>; Tue, 9 Jan 2001 21:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbRAJCTR>; Tue, 9 Jan 2001 21:19:17 -0500
Received: from mail-out1.apple.com ([17.254.0.52]:42213 "EHLO
	mail-out1.apple.com") by vger.kernel.org with ESMTP
	id <S129764AbRAJCTL>; Tue, 9 Jan 2001 21:19:11 -0500
Date: Tue, 9 Jan 2001 18:18:05 -0800 (PST)
From: Dave Zarzycki <dave@zarzycki.org>
To: "David S. Miller" <davem@redhat.com>
cc: <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <200101100114.RAA07780@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0101091743490.1954-100000@batman.zarzycki.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, David S. Miller wrote:

> Ignore Ingo's comments about the MSG_NOCOPY flag, I've not included
> those parts in the zerocopy patches as they are very controversial
> and require some VM layer support.

Okay, I talked to some kernel engineers where I work and they were (I
think) very justifiably skeptical of zero-copy work with respect to
read/write style APIs.

> Basically, it pins the userspace pages, so if you write to them before
> the data is fully sent and the networking buffer freed, they get
> copied with a COW fault.

Yum... Assuming a gigabit ethernet link is saturated with the
sendmsg(MSG_NOCOPY) API, what is CPU utilization like for a given clock
speed and processor make? It is any different than the sendfile() case?

davez

-- 
Dave Zarzycki
http://thor.sbay.org/~dave/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
