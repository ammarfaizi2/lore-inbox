Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbULAGsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbULAGsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 01:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbULAGsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 01:48:08 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:39811 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261316AbULAGsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 01:48:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=QAJkHSAwd0TePHatV+cCYbS7uVI70PtpTTOf8pGo7wAq3AMM/4/LNAdpMl4hYfXpDkofS2rOQVFPcXTCA82nGC87T3Q01M2X5PJqE9cE4gVNsIUKU4IPZ378eWzObuxl9MzQsGMgrEE6DiXst1OrbrJMsN5ZFzywRq/C1Ia6yLI=
Message-ID: <2ff21628041130224830d46fd8@mail.gmail.com>
Date: Wed, 1 Dec 2004 12:18:03 +0530
From: BAIN <bainonline@gmail.com>
Reply-To: BAIN <bainonline@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Cc: Linus Torvalds <torvalds@osdl.org>, Alexandre Oliva <aoliva@redhat.com>,
       dhowells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
In-Reply-To: <1101863177.4574.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	 <1101854061.4574.4.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411301447570.22796@ppc970.osdl.org>
	 <1101858657.4574.33.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411301605500.22796@ppc970.osdl.org>
	 <1101860688.4574.50.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411301636050.22796@ppc970.osdl.org>
	 <1101862057.4574.67.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411301656051.22796@ppc970.osdl.org>
	 <1101863177.4574.71.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Dec 2004 01:06:17 +0000, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 2004-11-30 at 16:57 -0800, Linus Torvalds wrote:
> > This isn't even a "fix". It's a cleanup. It goes under the same rules
> > a spelling fix does.
> 
> So you don't see a long-term technical benefit in cleaning up the
> API/ABI we export to userspace so that userspace stops depending on
> stuff which just isn't supposed to be there? It's all just cosmetic
> masturbation as far as you're concerned? There's no point in trying to
> get to the point where we don't need to separately maintain a
> glibc-kernheaders package because it can be taken directly from the
> kernel?

There obviously _is_ a technical benefit. And to put out second usual
argument used to reject patches, this benefit is desirable/matters to
more than single digit number of users.

But lets face it, the changes you guies are discussing in this long
thread are _massive_. May be not so much theorotical mass. In theory
this is just a trivial movement of text from file to file with new
rules enforced on adding new text.
But this does boil down to a great number of user interfaces being
touched. And as far as the linux engineering practices go, this is
_huge_.

The costs are high, each header file change is going to affect
everything, the regression testing is going to be pain if we actually
go do the modifications suggested by this thread.

And lets face it, with a retard[1] chosen as our leader , _mistakes
will happen_. Things will _break_ and any decision taken will more
often be a false one.

But we already know a better way to do things. After all thats how we
have taken linux to the place where it is today. We can just start
making the changes. In small steps. See if anyone is really bothered
by the change. See if enough people give you feedback so that you are
bothered to propagate the change to newer level.

I would much rather like to see the glibc-kernelheaders shrunk by few
bytes every 3-4 months or so. And yes this actually has a chance that
it may never happen.

The whole "put forward an idea get a consensus" and then "try to
engineer it" works well for theory. But not in practise. In the end,
only the good things prevail not because they were created good, but
more because bad things can't servive. Leave the whole idea of "putting
a research together and try to do the ultimate right" for the FreeBSD
team.

And don't try to do the ultimate right without any reasearch, thats
microsoft's domain.

In summary, splitting the headers could be a good idea. But to have
any acceptance you need to prove it by practical examples. And when
you do new things, be prepared to accept that they might fail in
practise.

BAIN

[1]see: 
http://marc.free.net.ph/message/20041109.161141.2f4e1246.html
