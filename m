Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVCCTnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVCCTnx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 14:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVCCTnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:43:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43154 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261194AbVCCTeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:34:18 -0500
Date: Thu, 3 Mar 2005 14:33:58 -0500
From: Dave Jones <davej@redhat.com>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       greg@kroah.com, torvalds@osdl.org, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303193358.GA29371@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	greg@kroah.com, torvalds@osdl.org, rmk+lkml@arm.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002047.GA10434@kroah.com> <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org> <20050303081958.GA29524@kroah.com> <4226CCFE.2090506@pobox.com> <20050303090106.GC29955@kroah.com> <4226D655.2040902@pobox.com> <20050303021506.137ce222.akpm@osdl.org> <20050303170759.GA17742@ti64.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303170759.GA17742@ti64.telemetry-investments.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 12:07:59PM -0500, Bill Rugolsky Jr. wrote:

 > IMHO, Jeff Garzik has made two very useful points in this thread:
 > 
 > 1. The number of changesets flowing towards the Linus kernel is accelerating,
 >    so the kernel developers should be trying to accelerate the merging process,
 >    not introducing delays.

If you accelerate the merging process, you're lowering the review process.
The only answer to get regressions fixed up as quickly as possible
(because prevention is nigh on impossible at the current rate, so
 any faster is just absurd), would be more regular releases, so that
they got spotted quicker.

 > Dave has been building "unstable" bleeding-edge Fedora kernels from
 > 2.6.x-rcM-bkN, as well as "test" kernels for Fedora updates;

Actually only rawhide (FC4-to-be) has been getting -rc-bk patches.
The FC2/FC3 updates have been release versions only, with -ac patches.
(and also some additional patches backing out bits of the -ac)
During a test cycle (Ie, after FC4test1 is released, but before FC4 gold)
is the only time Fedora users regularly test a -rc-bk tree.
This is part of the problem with rebasing the existing releases to
new kernels. It's shoving a largely untested codebase into a release
that was never tested in that combination. It's expected that some
stuff will break, but the volume of breakage is increasing as time goes on.
Even if _I_ stopped rebasing the Fedora kernel, some of our users
will still want to build and run the latest kernel.org kernel on their
FC2 boxes. We shouldn't be expecting them to have to rebuild half of
their userspace just because we've been sloppy and broke interfaces.

		Dave

