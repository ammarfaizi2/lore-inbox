Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266598AbUGKOEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266598AbUGKOEr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 10:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266599AbUGKOEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 10:04:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63155 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266598AbUGKOEp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 10:04:45 -0400
Date: Sun, 11 Jul 2004 15:04:45 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andi Kleen <ak@muc.de>
Cc: Matthew Wilcox <willy@debian.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: serious performance regression due to NX patch
Message-ID: <20040711140445.GB5889@parcelfarce.linux.theplanet.co.uk>
References: <2giKE-67F-1@gated-at.bofh.it> <2gIc8-6pd-29@gated-at.bofh.it> <2gJ8a-72b-11@gated-at.bofh.it> <2gJhY-776-21@gated-at.bofh.it> <2gJrv-7kp-5@gated-at.bofh.it> <2gLD2-qn-3@gated-at.bofh.it> <m3wu1a8xzv.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3wu1a8xzv.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 03:38:44PM +0200, Andi Kleen wrote:
> Matthew Wilcox <willy@debian.org> writes:
> 
> > On Sun, Jul 11, 2004 at 03:02:25AM -0700, Andrew Morton wrote:
> >> Apropos of nothing much, CONFIG_X86 would be preferreed here, but x86_64
> >> defines that too.
> >
> > IMO, x86-64 should stop defining CONFIG_X86.  It's far more common
> > to say "X86 && !X86_64" than it is to say X86.  How about defining
> > CONFIG_X86_COMMON and migrating usage of X86 to X86_COMMON?
> 
> Definitely not in 2.6 because it has far too much potential to 
> add subtle bugs, and that is not appropiate for a stable release. 
> In 2.7 maybe.
> 
> Buy I would prefer to just add an truly i386 specific define 
> like Andrew proposed.

We already had an i386 specific define.  You chose to hijack it.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
