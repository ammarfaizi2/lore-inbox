Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131633AbQKJTwZ>; Fri, 10 Nov 2000 14:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131516AbQKJTwP>; Fri, 10 Nov 2000 14:52:15 -0500
Received: from praseodumium.btinternet.com ([194.73.73.82]:63181 "EHLO
	praseodumium.btinternet.com") by vger.kernel.org with ESMTP
	id <S131657AbQKJTv4>; Fri, 10 Nov 2000 14:51:56 -0500
From: davej@suse.de
Date: Fri, 10 Nov 2000 19:51:52 +0000 (GMT)
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: CPU detection revamp (Request for comments)]
In-Reply-To: <3A0C3C7F.FF594CE9@transmeta.com>
Message-ID: <Pine.LNX.4.21.0011101950030.552-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, H. Peter Anvin wrote:

> That is actually correct -- the K6-2 doesn't actually have mtrr and sep,
> but has syscall and k6_mtrr instead (the stepping bug causes k6_mtrr not
> to show up.)  Part of the bugginess of the old system was using one flag
> for multiple purposes.  This was Linux' doing, not AMD's, by the way.

Yep, after the c->x86_mask = tfms & 15; change I got the correct
stepping, and the flags are now correct:-

features : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr

regards,

davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
