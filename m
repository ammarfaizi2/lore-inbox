Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVDZFv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVDZFv0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 01:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVDZFv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 01:51:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:47574 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261340AbVDZFvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 01:51:06 -0400
Date: Mon, 25 Apr 2005 22:50:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Len Brown <len.brown@intel.com>
Cc: greg@kroah.com, pavel@ucw.cz, drzeus-list@drzeus.cx, torvalds@osdl.org,
       pasky@ucw.cz, linux-kernel@vger.kernel.org, lm@bitmover.com
Subject: Re: Linux 2.6.12-rc3
Message-Id: <20050425225033.4cc47221.akpm@osdl.org>
In-Reply-To: <1114493158.2937.253.camel@d845pe>
References: <20050421162220.GD30991@pasky.ji.cz>
	<20050421232201.GD31207@elf.ucw.cz>
	<20050422002150.GY7443@pasky.ji.cz>
	<20050422231839.GC1789@elf.ucw.cz>
	<Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org>
	<20050423111900.GA2226@openzaurus.ucw.cz>
	<Pine.LNX.4.58.0504230654190.2344@ppc970.osdl.org>
	<426A7775.60207@drzeus.cx>
	<20050423220213.GA20519@kroah.com>
	<20050423222946.GF1884@elf.ucw.cz>
	<20050423233809.GA21754@kroah.com>
	<20050424032622.3aef8c9f.akpm@osdl.org>
	<1114493158.2937.253.camel@d845pe>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown <len.brown@intel.com> wrote:
>
> ...
> Also, I would think Bitmover would be interested in having you enabled
> to keep people like me as happy paying customers.

hm.  I guess I can continue to use bk until the end of July or until we hit
the 65535th cset.  After that things become murky.

> The question for bk use is what do we do for a reference "Linus tree"
> history.  It would be most effective if we could have a single bk history
> rather than everybody rolling their own.

yes, someone needs to set up a bk tree which is fed diffs from Linus's git
tree.  Let's call this the linus-git-bk-tree.  You then pull this into the
acpi tree.

> > - How do I do a bk `gcapatch' is there is no Linus bk tree to base it off?
> > 
> > - If none of the above, which maintainers will put up-to-date raw patches
> >   in places where Andrew can get at them?
> 
> I can do this if you require it.

Once you have the linus-git-bk-tree, then yes, it would be very nice if you
(or someone else) were to set up another machine which every six hours or
so does

	cd bk-acpi/
	bk pull bk://linux-acpi.bkbits.net/to-akpm
	gcapatch > /ftp-dir/bk-acpi.patch

and makes /ftp-dir available.  The same machine could also publish all the
other bk trees, such as Tony's
http://lia64.bkbits.net/linux-ia64-test-2.6.12.  I have all the bk url's.

The fact that some developers change the bk URL between major kernel
releases will be a bit of a pain.

>  The current "acpi patch" includes
> 68 patches: 200 files changed, 7780 insertions(+), 5455 deletions(-)
> 
> Everything in it is intended to go to Linus on day-one of 2.6.13.
> Some of it should really go into 2.6.12 - but frankly, I hesitate
> to touch 2.6.12 while the tools are in such flux.

"flux".  I've never seen it spelled that way before ;)

> > I don't know how all this will pan out.  I guess the next -mm won't have
> > many subsystem trees and I'll gradually add them as things get sorted out.
> 
> Please do not roll -mm without including the ACPI sub-system.
> -mm provides the broadest pre-integration test coverage we've ever had.
> It has allowed us to significantly reduce regressions in Linus' tree
> as we encounter the inevitable setbacks associated with making
> the ACPI sub-system in Linux the best in the industry.

OK, well once we have linus-git-bk-tree I can continue to do bk pulls until
either the bk license explodes or we hit the 65536-csets problem.

After that, the automated-patch-exports thing above would be needed.

In the very short-term, please email me the patch.  Some automated daily
thing would suit.

