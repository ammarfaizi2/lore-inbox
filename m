Return-Path: <linux-kernel-owner+w=401wt.eu-S1753745AbWLRKap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbWLRKap (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 05:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753750AbWLRKao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 05:30:44 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49172 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744AbWLRKao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 05:30:44 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net>
	<20061214005532.GA12790@suse.de>
	<Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
	<458171C1.3070400@garzik.org>
	<Pine.LNX.4.64.0612140855250.5718@woody.osdl.org>
	<20061214170841.GA11196@tuatara.stupidest.org>
	<20061214173827.GC3452@infradead.org>
	<20061214175253.GB12498@tuatara.stupidest.org>
	<Pine.LNX.4.61.0612141907450.12730@yvahk01.tjqt.qr>
Date: Mon, 18 Dec 2006 03:28:38 -0700
In-Reply-To: <Pine.LNX.4.61.0612141907450.12730@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Thu, 14 Dec 2006 19:09:51 +0100 (MET)")
Message-ID: <m1vek9sdk9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

> On Dec 14 2006 09:52, Chris Wedgwood wrote:
>>On Thu, Dec 14, 2006 at 05:38:27PM +0000, Christoph Hellwig wrote:
>>
>>> Yes, EXPORT_SYMBOL_INTERNAL would make a lot more sense.
>>
>>A quick grep shows that changing this now would require updating
>>nearly 1900 instances, so patches to do this would be pretty large and
>>disruptive (though we could support both during a transition and
>>migrate them over time).
>
> I'd prefer to do it at once. But that's not my decision so you anyway do what
> you want.
>
> That said, I would like to keep EXPORT_SYMBOL_GPL, because EXPORT and INTERNAL
> is somehow contrary. Just a wording issue.

I would suggest that we make the prefix MODULE and not EXPORT.  It
more accurately conveys what we are trying to say, and it doesn't
have the conflicting problem with INTERNAL.

I don't know if it is actually worth doing a great rename for such
a simple clarification in language.  But it is worth considering
because it would more strongly convey that we don't expect these
symbols to be used by everything.

Eric
