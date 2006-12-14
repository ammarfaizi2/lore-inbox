Return-Path: <linux-kernel-owner+w=401wt.eu-S1750838AbWLNTmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWLNTmj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 14:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWLNTmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 14:42:39 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:5499 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbWLNTmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 14:42:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kGMgMGl+JxbQya/hjJMMxNEIw4omW2qNni+lg0+PqH6IkuxS601v/ydJjz1EydAV+dbzXbygD7RkBWkeS7gupEPXD4pJXmgVpKYvzFs5PTP2AjwIx9pStanpvkcB0wRqOC7TTjRWDAe5lvClawLuMM+hkFvgszqC5fQMnfXyPtQ=
Message-ID: <7b69d1470612141142k63cc7d11l89c0a7f26acc631a@mail.gmail.com>
Date: Thu, 14 Dec 2006 13:42:35 -0600
From: "Scott Preece" <sepreece@gmail.com>
To: "Chris Wedgwood" <cw@f00f.org>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Cc: "Eric Sandeen" <sandeen@sandeen.net>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Jeff Garzik" <jeff@garzik.org>,
       "Greg KH" <gregkh@suse.de>, "Jonathan Corbet" <corbet@lwn.net>,
       "Andrew Morton" <akpm@osdl.org>, "Martin Bligh" <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061214183956.GA13692@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061214003246.GA12162@suse.de> <20061214005532.GA12790@suse.de>
	 <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
	 <458171C1.3070400@garzik.org>
	 <Pine.LNX.4.64.0612140855250.5718@woody.osdl.org>
	 <20061214170841.GA11196@tuatara.stupidest.org>
	 <20061214173827.GC3452@infradead.org>
	 <20061214175253.GB12498@tuatara.stupidest.org>
	 <458194B8.1090309@sandeen.net>
	 <20061214183956.GA13692@tuatara.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/06, Chris Wedgwood <cw@f00f.org> wrote:
> On Thu, Dec 14, 2006 at 12:15:20PM -0600, Eric Sandeen wrote:
>
> > Please don't use that name, it strikes me as much more confusing
> > than EXPORT_SYMBOL_GPL, even though I agree that _GPL doesn't quite
> > convey what it means, either.
>
> Calling internal symbols _INTERNAL is confusing?

I think it's the combination of "INTERNAL" and "EXPORT" that seems
contradictory - "If it's internal, why are you exporting it?"

I think "EXPORT_SYMBOL_GPL_ONLY" or "...ONLY UNDER_GPL" would make the
meaning clearer, but I don't really think the gain is worth the pain.
Anybody using kernel interfaces ought to be able to figure it out.

>
> But those symbols aren't, they're about internal interfaces that might
> change.

Folks who think this is likely to make a difference in court might
want to look at
<http:www.linuxworld.com/news/2006/120806-closed-modules2.html> for a
litany of court cases that have rejected infringement claims where a
much sterner effort had been made to hide or block use of interfaces.
The article claims that courts have increasingly found that
interfacing your code to an existing work is not infringement,
regardless of what you have to work around to do it.

Of course, that's one author's reading of the case law and I'm sure
there are others who disagree, but it's something you'd want to keep
in mind in calculating the expected value of a suit...

scott
