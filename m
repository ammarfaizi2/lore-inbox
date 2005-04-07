Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVDGRz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVDGRz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVDGRz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:55:28 -0400
Received: from smtp.istop.com ([66.11.167.126]:3041 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262536AbVDGRxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:53:21 -0400
From: Daniel Phillips <phillips@istop.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Kernel SCM saga..
Date: Thu, 7 Apr 2005 13:54:34 -0400
User-Agent: KMail/1.7
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org> <20050407171006.GF8859@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050407171006.GF8859@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504071354.34581.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 April 2005 13:10, Al Viro wrote:
> The point being, both history and well, publishable result can be expressed
> as series of small steps, but they are not the same thing.  So far all I've
> seen in the area (and that includes BK) is heavily biased towards history
> part and attempts to use this stuff for manipulating patch series turn into
> fighting the tool.
>
> I'd *love* to see something that can handle both - preferably with
> history of reordering, etc. being kept.  IOW, not just a tree of changesets
> but a lattice - with multiple paths leading to the same node.  So far
> I've seen nothing of that kind ;-/

Which is a perfect demonstration of why the scm tool has to be free/open 
source.  We should never have had to plead with BitMover to extend BK in a 
direction like that, but instead, just get the source and make it do it, like 
any other open source project.

Three years ago, there was no fully working open source distributed scm code 
base to use as a starting point, so extending BK would have been the only 
easy alternative.  But since then the situation has changed.  There are now 
several working code bases to provide a good starting point: Monotone, Arch, 
SVK, Bazaar-ng and others.

Sure, there are quibbles about all of those, but right now is not the time for 
quibbling, because a functional replacement for BK is needed in roughly two 
months, capable of losslessly importing the kernel version graph.  It only 
has to support a subset of BK functionality, e.g., pulling and cloning.  It 
is ok to be a little slow so long as it is not pathetically slow.  The 
purpose of the interim solution is just to get the patch flow process back 
online.

The key is the _lossless_ part.  So long as the interim solution imports the 
metadata losslessly, we have the flexibility to switch to a better solution 
later, on short notice and without much pain.

So I propose that everybody who is interested, pick one of the above projects 
and join it, to help get it to the point of being able to losslessly import 
the version graph.  Given the importance, I think that _all_ viable 
alternatives need to be worked on in parallel, so that two months from now we 
have several viable options.

Regards,

Daniel
