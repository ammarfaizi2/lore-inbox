Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVADUTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVADUTv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVADUT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:19:27 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:24845 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262126AbVADUSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:18:06 -0500
Date: Tue, 4 Jan 2005 21:09:12 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Felipe Alfaro Solana <lkml@mac.com>
Cc: Rik van Riel <riel@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       William Lee Irwin III <wli@debian.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Andries Brouwer <aebr@win.tue.nl>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Subject: Re: starting with 2.7
Message-ID: <20050104200912.GA22075@alpha.home.local>
References: <200501032059.j03KxOEB004666@laptop11.inf.utfsm.cl> <0F9DCB4E-5DD1-11D9-892B-000D9352858E@mac.com> <Pine.LNX.4.61.0501031648300.25392@chimarrao.boston.redhat.com> <5B2E0ED4-5DD3-11D9-892B-000D9352858E@mac.com> <20050103221441.GA26732@infradead.org> <20050104054649.GC7048@alpha.home.local> <20050104063622.GB26051@parcelfarce.linux.theplanet.co.uk> <9F909072-5E3A-11D9-A816-000D9352858E@mac.com> <Pine.LNX.4.61.0501040735410.25392@chimarrao.boston.redhat.com> <85546E06-5E50-11D9-A816-000D9352858E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85546E06-5E50-11D9-A816-000D9352858E@mac.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 01:59:51PM +0100, Felipe Alfaro Solana wrote:
> >How much work are you willing to do to make this happen ? ;)
> 
> As much as needed :-)

It's harder than you think. If hundreds of developpers work on a version
without thinking a second about separating security fixes and new features,
you'll have a hard time extracting them all ! But generally (I said generally),
security fixes are separated because noone knows from the start if a fix will
be the best one, so they need to be able to revert it easily. More common
problems involve changes to the core to support new features, or to satisfy
some developper's own idea of what is good and what is bad.

> >It would be easy enough for you to take 2.6.9 and add only
> >security fixes and critical bugfixes to it for the next 6
> >months - that would give your binary vendors a stable
> >source base to work with...
> 
> I would... if it was easy enough to find some form of a security 
> patches pool. It's usually difficult to find a site where I can 
> download security patches for older versions of vanilla kernels. I have 
> the feeling that this security fixes go mainstream onto the latest 
> kernel versions, leaving users in hands of their distribution (either 
> to upgrade to a new distribution kernel, or waiting for the 
> distribution vendor to backport).

Anyway, when you manage your own distribution, you have no other solution
than reading lkml daily (better: continuously) to grab the required fixes
and apply them to your local tree. If you feel that sometime you won't be
able to do the backport, either you can ask on lkml, people are often willing
to help, or you need to rely on other people's work (read distro kernels).

> Thus, sometimes people are forced to upgrade to a new kernel version as 
> such security patches either don't exist for older kernel versions, are 
> difficult to find, or need backporting (and I'm not knowledgeable 
> enough to backport nearly half of them), and since the new kernel 
> version introduces new features -- which sometimes do break existing 
> propietary software -- users starts complaining.

Not only proprietary software. I nearly don't use any (vmware a few times a
year). Viro would tell you that the problem is on the editor's side. I have
often been annoyed by opensource patches breakage. Try to use the same PaX
patch for 4 months, for example, without getting rejects nor wrongly applied
chunks !

Another problem is when code organisation changes. For example, in 2.4.29pre3,
some xfs files have moved, which break the 2.4.28 vserver patch. Fixing it was
not difficult, but it's just an example of things which could be avoided in a
stable tree (and I'm sure that Christoph will flame me for saying this).

> However, it's true that distributions, like Red Hat or Fedora, try at 
> its best to keep the kernel as stable as possible. For example, FC3 
> seems to sport something like a 2.6.9 kernel, but sometimes those 
> kernels are so heavily patched that some closed-source software doesn't 
> work.

Once again, my personal concern is about opensource code not being always
possible to apply without lots of efforts. This problem is very old, it
recently cost many efforts to several people to try to replace IDE code
in 2.6. In general, it's diffcult to work aside of the kernel and follow
it closely, whether you're opensource or not.

> I know I can choose open software and hardware vendors compatible with 
> Linux, but sometimes I cannot. I like VMware, and I use it a lot. I'm 
> not willing to sacrifice it, and that's the reason I think 2.6 must 
> fork as soon as possible into 2.7.

Well, it will be simpler when vmware authors will be fed up too and switch
to another OS (I'm not talking about the one which you cannot use in console
mode), you'll just have to follow them :-)

Regards,
Willy

