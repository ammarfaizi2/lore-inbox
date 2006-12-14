Return-Path: <linux-kernel-owner+w=401wt.eu-S1751957AbWLNSQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbWLNSQV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 13:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbWLNSQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 13:16:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39575 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbWLNSQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 13:16:20 -0500
Message-ID: <458194B8.1090309@sandeen.net>
Date: Thu, 14 Dec 2006 12:15:20 -0600
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org> <458171C1.3070400@garzik.org> <Pine.LNX.4.64.0612140855250.5718@woody.osdl.org> <20061214170841.GA11196@tuatara.stupidest.org> <20061214173827.GC3452@infradead.org> <20061214175253.GB12498@tuatara.stupidest.org>
In-Reply-To: <20061214175253.GB12498@tuatara.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Thu, Dec 14, 2006 at 05:38:27PM +0000, Christoph Hellwig wrote:
> 
>> Yes, EXPORT_SYMBOL_INTERNAL would make a lot more sense.
> 
> A quick grep shows that changing this now would require updating
> nearly 1900 instances, so patches to do this would be pretty large and
> disruptive (though we could support both during a transition and
> migrate them over time).

Please don't use that name, it strikes me as much more confusing than
EXPORT_SYMBOL_GPL, even though I agree that _GPL doesn't quite convey
what it means, either.

EXPORT_SYMBOL_RESTRICTED?  EXPORT_SYMBOL_DERIVED?  At least something
which is not internally inconsistent would be good (how is something
which is exported "internal?")

And, as long as EXPORT_SYMBOL_GPL continues to check that the module
using it has a GPL license, then it really -is- exactly descriptive of
what it's doing and probably shouldn't be changed.  IIMHO.

-Eric
