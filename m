Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVCCO7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVCCO7W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 09:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVCCO7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 09:59:22 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:34315 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261797AbVCCO6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 09:58:55 -0500
Date: Thu, 3 Mar 2005 15:58:46 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       davem@davemloft.net, jgarzik@pobox.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303145846.GA5586@pclin040.win.tue.nl>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org> <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net> <20050303011151.GJ10124@redhat.com> <20050302172049.72a0037f.akpm@osdl.org> <20050303012707.GK10124@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303012707.GK10124@redhat.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: CollegeOfNewCaledonia: pastinakel.tue.nl 1189; Body=1 Fuz1=1 
	Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ha - a nice big thread. Issues include trivial fixes, testing,
and API stability.

-----
About trivial fixes:
davem: the day Linus releases we always get a pile of "missing MODULE_EXPORT()"
       type bug reports that are one liner fixes.
davej: So what was broken with the 2.6.8.1 type of release ?
akpm: But that _is_ a branch

I think we all like the 2.6.8.1 model.

davej: The only question in my mind is 'how critical does a bug have to be
       to justify a .y release'.

I think that is the wrong question. The question should be 'how trivial
should a fix be to be admissible in a .y release'. If something is important
but nonobvious, it should cause earlier release of 2.6.x+1.
No regressions in 2.6.x.y.

-----
About testing: users do not test p.q.r-suffix, they just test p.q.r
Solution: Release early, release often. No silly odd/even games.
jgarzik: I would prefer a weekly snapshot as the release

-----
API stability: Stable series like 2.0, 2.2, 2.4 try to maintain
the guarantee that user-visible APIs do not change. That goal
has disappeared, meaning that anything might break when one
upgrades from 2.6.14 to 2.6.16.
This is one of the big disadvantages of the new 2.6 way.

-----
A separate twig is that of when to call a release 'stable'.
Since there is no good way to predict, the solution is 'wait and see'.
'Stable' also depends on the type of use. It is easier to leave
construction of stable kernels to separate people and trees.
With some delay they can have the benefit of hindsight.

Andries
