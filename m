Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131072AbQKRC3A>; Fri, 17 Nov 2000 21:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131149AbQKRC2u>; Fri, 17 Nov 2000 21:28:50 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:34739 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131072AbQKRC2n>;
	Fri, 17 Nov 2000 21:28:43 -0500
Date: Fri, 17 Nov 2000 20:58:41 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Nix <nix@esperi.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Inconsistent behaviour of rmdir
In-Reply-To: <87k8a23w39.fsf@loki.wkstn.nix>
Message-ID: <Pine.GSO.4.21.0011172048340.18150-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 18 Nov 2000, Nix wrote:

> Alexander Viro <viro@math.psu.edu> writes:
> 
> > If every way from foo to target goes through the source rename(source,target)
> > _will_ make the graph disconnected. Checking that for generic DAG is a hell.
> 
> Why do you say this? Algorithms for cycle detection are comparatively
> computationally expensive, to be sure, but they are well understood. In

s/computationally/& and IO/. If we are thinking about the same algorithm -
good luck doing that if your data structures are on disk. Think of
reference locality in that animal. Try to estimate the amount of IO and
fun with seeks. It's nice when you have your data in-core, but when it's
on-disk and you want reasonable locality of references for normal uses...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
