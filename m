Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751931AbWCFXBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbWCFXBW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 18:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbWCFXBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 18:01:21 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:8609 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751931AbWCFXBU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 18:01:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ImUsOhq5voX/kma+wfsAXLwWfdRh+CaDBuw5XbBdKP1j7Jrj8d/AcTJb01gIGobdwxPntm5UtYFzuVj/njZ+At58u5KeFZmgr63WvadcJVspTAcIFbFvlIt6W8g5UDVZw+NLwxPlfVgA7xdNPZERxznCYXeMQaZXyAICFJSvmBk=
Message-ID: <9a8748490603061501r387291f0ha10e9e9fe3c9e060@mail.gmail.com>
Date: Tue, 7 Mar 2006 00:01:19 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       "Andrea Arcangeli" <andrea@suse.de>,
       "Mike Christie" <michaelc@cs.wisc.edu>,
       "James Bottomley" <James.Bottomley@steeleye.com>,
       "Jens Axboe" <axboe@suse.de>, "Pekka Enberg" <penberg@cs.helsinki.fi>
In-Reply-To: <Pine.LNX.4.64.0603061445350.13139@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603060117.16484.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
	 <200603062136.17098.jesper.juhl@gmail.com>
	 <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com>
	 <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com>
	 <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
	 <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>
	 <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061445350.13139@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Mon, 6 Mar 2006, Linus Torvalds wrote:
> >
> > Either revert it, or try this (TOTALLY UNTESTED!!!) patch..
>
> Don't even bother with the untested patch.
>
> > +     for (gfporder = 0 ; gfporder < MAX_GFP_ORDER; gfporder++) {
>
> At a minimum, this "<" needs to be "<=".
>
> After that, it might even work. Not that I can convince me that the test
> for "offslab_limit" ever even triggers, so..
>

Ehh, it's getting pretty clear that you are looking at
2.6.16-rc5-git<latest> and I'm using -mm here, since that code is not
present in mm/slab.c in 2.6.16-rc5-mm2 in anything near that form.

And since 2.6.16-rc5-git8 is not experiencing problems I'd suggest you
perhaps instead take a look at what's in -mm... That's where we need
to work (it seems) to find the bug...

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
