Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVAEDCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVAEDCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 22:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVAEDBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 22:01:10 -0500
Received: from lakermmtao04.cox.net ([68.230.240.35]:15606 "EHLO
	lakermmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262230AbVAEC6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:58:18 -0500
In-Reply-To: <20050104180541.P2357@build.pdx.osdl.net>
References: <1104374603.9732.32.camel@krustophenia.net> <20050103140359.GA19976@infradead.org> <1104862614.8255.1.camel@krustophenia.net> <20050104182010.GA15254@infradead.org> <87u0pxhvn0.fsf@sulphur.joq.us> <1104865198.8346.8.camel@krustophenia.net> <1104878646.17166.63.camel@localhost.localdomain> <20050104175043.H469@build.pdx.osdl.net> <1104890131.18410.32.camel@krustophenia.net> <20050104180541.P2357@build.pdx.osdl.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A34D1E8C-5EC5-11D9-B35E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Date: Tue, 4 Jan 2005 21:58:12 -0500
To: Chris Wright <chrisw@osdl.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 04, 2005, at 21:05, Chris Wright wrote:
> No, you're not.  I think Alan's just saying the gid based checks
> are suboptimal if there's a cleaner way to do it (to which I agree).
> Personally, I don't have a big problem with the Realtime LSM.  I've 
> helped
> you with it, and suggested a few times that I'd prefer it to be 
> generic;
> but never stepped up to deliver code of that sort.  Since it's your 
> itch,
> you've scratched it, and it's quite simple and contained, I consider
> it acceptable.

Here's a relatively simple idea: Why not make the "Realtime LSM"
just check for a certain "Realtime" credential in the new credential
store (Patch is in 2.6.10, see [1] for control program).  You would
mark it as a system credential and give access to that credential via
the appropriate capability with a small utility program.

Of course, I _do_ respect that I am not providing a patch which they
have done.  I think this serves a useful place and should probably be
included as-is, for now.  A later update to make it use a better
mechanism would be nice, though. :-)

[1] http://people.redhat.com/~dhowells/keys/keyctl.c

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


