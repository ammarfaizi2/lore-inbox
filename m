Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVCCBcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVCCBcF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 20:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVCCB3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:29:04 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:18632 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261407AbVCCB1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:27:20 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 3 Mar 2005 12:27:06 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16934.26602.88841.50950@cse.unsw.edu.au>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
In-Reply-To: message from Andrew Morton on Wednesday March 2
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<16934.22078.129692.140147@cse.unsw.edu.au>
	<20050302164847.294e7bca.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday March 2, akpm@osdl.org wrote:
> 
> Only davem, AFAIK.  All the other trees get auto-sucked into -mm for
> testing. 

Ok, I got the feeling it was more wide spread than that, but I
apparently misread the signs (people mentioning that had 'patches
queued for Linus' and such).

>           Generally the owners of those trees make the decision as to which
> of their code has been sufficiently well-tested for a Linus merge, and when
> that should happen.

I wonder if there is a problem here.
Who is in a position to judge when a patch is ready to be merged?
I suspect that it would be hard for a developer to be objective about
the readiness of their own patches (I know all my patches are perfectly
ready the moment I create them, despite what experience tells me :-)

Assuming we have a 'stable', a 'testing' and a 'devel' series
(whatever actual numbering gets used for them(*)), then maybe it is ok
for a developer to judge if it is ready for 'testing', but it should
really have either some minimum time in 'testing' or independent
review before being allowed into 'stable'.

Are you and Linus able to handle the independent review load?
Should every developer/maintainer find someone to review any patches
that they think should 'jump the queue'.
(Would anyone like to review my nfs/raid patches for me?  I review
patches I get from others, but find it very hard to review my own
work.  Andrew does a good job, but does miss things sometimes). 

NeilBrown


(*) Options for naming:

Devel              Testing                 Stable
2.ODD.X            2.EVEN.X                2.EVEN.X-ac
2.6.X-mm           2.6.X-rc                2.6.X
2.6.X-mm           2.6.ODD                 2.6.EVEN
2.6.X-mm           2.6.X                   2.6.X + patch addenda <--- my preferred
2.6.X-pre          2.6.X-rc                2.6.X

It doesn't matter much what you call them, but I think the three-way
distinction is needed, and there needs to be a well-understood set of
rules for patches moving from one to the next.

NeilBrown
