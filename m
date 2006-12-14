Return-Path: <linux-kernel-owner+w=401wt.eu-S932890AbWLNSwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932890AbWLNSwe (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 13:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbWLNSwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 13:52:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47602 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932890AbWLNSwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 13:52:33 -0500
Date: Thu, 14 Dec 2006 10:51:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Eric Sandeen <sandeen@sandeen.net>, Christoph Hellwig <hch@infradead.org>,
       Jeff Garzik <jeff@garzik.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <20061214183956.GA13692@tuatara.stupidest.org>
Message-ID: <Pine.LNX.4.64.0612141045210.5718@woody.osdl.org>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net>
 <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
 <458171C1.3070400@garzik.org> <Pine.LNX.4.64.0612140855250.5718@woody.osdl.org>
 <20061214170841.GA11196@tuatara.stupidest.org> <20061214173827.GC3452@infradead.org>
 <20061214175253.GB12498@tuatara.stupidest.org> <458194B8.1090309@sandeen.net>
 <20061214183956.GA13692@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2006, Chris Wedgwood wrote:
> 
> Calling internal symbols _INTERNAL is confusing?

Well, I'm not sure the _INTERNAL name is all that much better than the 
_GPL one.

In many ways, the _GPL one describes the _effects_ better, and also points 
out the reason _why_ something is marked differently. Sure, it's marked 
becasue it's internal, but why is does that have to be pointed out at all? 
Why not use the same EXPORT_SYMBOL? The answer to that is the "GPL" part, 
ie the expectation that internal symbols are so internal that they have 
license effects.

And if you were an external vendor doing binary only modules, would you 
react to "internal"? It wouldn't have the same "oh, _that_ is what it is 
all about" thing, would it?

So I do agree that we have probably done a bad job of explaining why that 
_GPL thing makes sense, and what it means on a deeper level (the license 
thing is a very superficial thing, but its worth naming just because the 
superficial thing is also the biggest _impact_ - even if it may not be the 
underlying deeper _reason_ for it).

So which makes more sense from a naming standpoint: the superficial impact 
that is what _matters_ for people, or the more subtle issue that causes it 
to have that impact?

I think that question is what it boils down to, and at least personally, 
while I see both things as being worthwhile, I think the superficial thing 
is the one that needs pointing out, because it's the one that may change 
your behaviour (while the deeper _meaning_ is more of just an 
explanation).

But I don't personally care that deeply. I mostly care about the fact that 
changing the name now would just be inconvenient and unnecessary churn, 
and that's probably my biggest reason to not want to do it ;)

			Linus
