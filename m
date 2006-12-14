Return-Path: <linux-kernel-owner+w=401wt.eu-S932888AbWLNSkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932888AbWLNSkA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 13:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932890AbWLNSkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 13:40:00 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:26115 "HELO
	smtp114.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932888AbWLNSj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 13:39:59 -0500
X-YMail-OSG: ZdKPwvIVM1n9IZI.YBKs0CcBXhCm.Do14e1WfB1wj1F3U0PtwR0BW06iCs5fV83ad.MBs9eBHsaWUTJAHZJBT1fVY88oDQoIf.1MPKYt0UcmZvCo2XqeASsm0KgRutdaElYw5bXzWYXIael8LofEb79Q8mmXr4i.T2t_prQzUehAFYmfmvLTn1mwbT4k
Date: Thu, 14 Dec 2006 10:39:56 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214183956.GA13692@tuatara.stupidest.org>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org> <458171C1.3070400@garzik.org> <Pine.LNX.4.64.0612140855250.5718@woody.osdl.org> <20061214170841.GA11196@tuatara.stupidest.org> <20061214173827.GC3452@infradead.org> <20061214175253.GB12498@tuatara.stupidest.org> <458194B8.1090309@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458194B8.1090309@sandeen.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 12:15:20PM -0600, Eric Sandeen wrote:

> Please don't use that name, it strikes me as much more confusing
> than EXPORT_SYMBOL_GPL, even though I agree that _GPL doesn't quite
> convey what it means, either.

Calling internal symbols _INTERNAL is confusing?

> EXPORT_SYMBOL_RESTRICTED?  EXPORT_SYMBOL_DERIVED?  At least
> something which is not internally inconsistent would be good (how is
> something which is exported "internal?")

But those symbols aren't, they're about internal interfaces that might
change.

> And, as long as EXPORT_SYMBOL_GPL continues to check that the module
> using it has a GPL license, then it really -is- exactly descriptive
> of what it's doing and probably shouldn't be changed.  IIMHO.

Well, if EXPORT_SYMBOL_GPL / EXPORT_SYMBOL_INTERNAL is about
documenting things, why restrict who can use them based on the
license?

Surely the licence is more about tainting the kernel and debugging not
politics?

Do we even need to check the license at all in that case?  Maybe a
better idea would be to embed where the source code is located and use
the non-existence of that for a tainting?

