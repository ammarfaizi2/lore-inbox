Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263155AbVAFWdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263155AbVAFWdf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 17:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbVAFWdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 17:33:23 -0500
Received: from holomorphy.com ([207.189.100.168]:27328 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263143AbVAFWbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:31:19 -0500
Date: Thu, 6 Jan 2005 14:30:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@muc.de>
Cc: Steve Longerbeam <stevel@mvista.com>, Hugh Dickins <hugh@veritas.com>,
       Ray Bryant <raybry@sgi.com>, Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Marcello Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, andrew morton <akpm@osdl.org>
Subject: Re: page migration patchset
Message-ID: <20050106223046.GB9636@holomorphy.com>
References: <Pine.LNX.4.44.0501052008160.8705-100000@localhost.localdomain> <41DC7EAD.8010407@mvista.com> <20050106144307.GB59451@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106144307.GB59451@muc.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 03:43:07PM +0100, Andi Kleen wrote:
> If nothing happens soon regarding the "other" hugetlb code I will
> forward port my SLES9 code. It already has NUMA policy support.
> For now you can remove the hugetlb policy code from mainline if you

This is not specifically directed at Andi...

I am rather unhappy with various activities ``surrounding'' hugetlb,
as I've received less than zero assistance in bughunting or fielding
problem reports or actual end-user requests. Instead, there are feature
patches, which of course ``compete with'' what I've already written
myself (completely crushed by private permavetoes before they were ever
posted, of course) and screw me out of credit for having done anything
while I slave away to fix bugs.

There is a relatively consistent pattern of my being steamrolled over
I'm rather sick of. Of course, this all exploits the fact that there
can can be no like response, as the entire force of the attack is
derived from upstream backing, which once obtained by one party, is
forever unavailable to others.

There are several problems occurring beyond what appears to be a very
strong social bias against my own work.

The first is strong architectural bias and weak or absent architectural
code sweeps on the parts of contributors. This has caused
nonfunctionality and bugs apparent upon inspection in the ``less
favored'' architectures.

The second is zero bugfixing or cross-architecture testing activity
apart from my own. This and the first in conjunction cast serious
doubt upon and increase the need for heavy critical examination of
so-called ``consolidation'' patches.

The third is inattention to backward compatibility. The operational
characteristics of hugetlb, however odd they may be, are effectively
set in stone by the requirement for backward compatibility. The mmap()
vs. truncate() behavioral changes were the first of the deviations from
this, and were rather ugly ones that put hugetlb at great variance with
all normal filesystems in its lack of support for expanding truncate
and bizarre expansion behavior during mmap(), which were neither
forward nor backward compatible. Changes in COW behavior directly
threaten to create a similar backward compatibility nightmare, where
zero consideration of such has yet been given.

The fourth is the inattention to outstanding issues in need of repair.
For instance, hugetlb's locking, inherited from the system call code,
desperately needs to be normalized, and no individual attention has
been given to this by those with purportedly vested interests in
hugetlb, though apparently numerous locking rearrangements have
appeared while inappropriately mixed with other changes.

The fifth is that many of the patches I've been sent are apparently
predicated on the assumption that the authors are exempt from
compliance with Documentation/CodingStyle.

Sixth is that patch presentations have overall been poor enough to
consider them well below general kernel standards. This includes both
poor changelogging and lacking separation of distinct behavioral
changes into distinct patches.

These six issues act in concert to severely aggravate preexisting
chaos with no effort whatsoever expended on the parts of contributors
to mitigate or correct it.

Obviously, I have no recourse, otherwise there would be no credible
threat of this kind of end-run tactic succeeding, and I've apparently
already been circumvented by pushing the things to distros anyway. So
I can do no more than kindly ask you to address issues 1-6 in your
patch presentations.

Not that I expect anyone to listen. No one ever has before. In fact,
given the precedents, it's more likely for this to provoke verbal and
several other kinds of retaliation than any kind of cooperation or
ostensibly useful effect. The only rational motive for this post is to
leave some kind of public record that I've been screwed over, unlike
the various other instances where I silently ``took it''. In all other
respects I will be heavily penalized for it.


-- wli
