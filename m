Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbUK3W61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbUK3W61 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbUK3W61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:58:27 -0500
Received: from box.punkt.pl ([217.8.180.66]:43531 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S262404AbUK3WzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:55:02 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Tue, 30 Nov 2004 23:52:51 +0100
User-Agent: KMail/1.7
Cc: Alexandre Oliva <aoliva@redhat.com>, David Howells <dhowells@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org> <orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411301423030.22796@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411301423030.22796@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411302352.51849.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On wtorek 30 listopad 2004 23:25, Linus Torvalds wrote:
> > You mean it can't break anything in a kernel build, or it can't break
> > anything except for userland apps that abused kernel headers and used
> > to get away with that?
>
> It can't break userland either.

Userland? And who's using vanilla kernel headers in userland? Duplicates 
maintainers can always fix stuff independent of kernel (and I do).

> > >  (b) there are people who will actually take _advantage_ of that
> > >      particular file (ie "just because I think so" doesn't fly).
> >
> > People who currently get to maintain duplicates of these header
> > contents will take immediate advantage of these changes, since they
> > will no longer have to maintain the duplicates.
>
> Wrong. They'll _still_ have to maintain duplicates, since they can't rely
> ont he end-user to have a recent enough kernel.

The end user uses a distro that does these things for him. If not, he needs to 
know his way around with finding working kernel headers, otherwise he won't 
be able to build anything (he surely isn't able now - which btw you're trying 
really hard to ignore).
I don't get your point.

> It's just that they can hopefully start _copying_ their dupliates more
> easily. But if you think the duplication goes away, then I don't want you
> to send me patches, because you don't understand the issues.

Yes. The more stuff gets separated, the less work duplicates maintainers have. 
Once all userland stuff gets extracted, those maintainers won't have anything 
else to do, maybe except releasing their final version and using it for 
backward compatibility. And that's what we're aiming at.


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
