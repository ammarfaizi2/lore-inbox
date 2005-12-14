Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbVLNWSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbVLNWSN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbVLNWSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:18:13 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:48098 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965025AbVLNWSM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:18:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OID/D8BNndrPyLRqIBlfte4HbzR1oOqNNGLpV5hZNyLSZg6vmv8mqoUXzNIiqVNE+V7C3oYyC2JmoSDW0IxIjgE9wQR2rLJquKOCNwzIPC0LwrjxlRUZLRWdF/p5lH51fWaND0lIMK/1OiEvrJbZwZwyeg4XdqvWe27aOa7/gdI=
Message-ID: <9a8748490512141418w2a3811a9iffe83b5f285e2910@mail.gmail.com>
Date: Wed, 14 Dec 2005 23:18:11 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051214221304.GE23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051214191006.GC23349@stusta.de>
	 <20051214140531.7614152d.akpm@osdl.org>
	 <20051214221304.GE23349@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/05, Adrian Bunk <bunk@stusta.de> wrote:
> On Wed, Dec 14, 2005 at 02:05:31PM -0800, Andrew Morton wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> > >
> > > Hi Linus,
> > >
> > > your patch to allow CC_OPTIMIZE_FOR_SIZE even for EMBEDDED=n has broken
> > > the EMBEDDED menu.
> >
> > It looks like that patch needs to be reverted or altered anyway.  sparc64
> > machines are failing all over the place, possibly due to newly-exposed
> > compiler bugs.
> >
> > Whether it's the compiler or it's genuine kernel bugs, the same problems
> > are likely to bite other architectures.
>
> The help text already contains a bold warning.
>
> What about marking it as EXPERIMENTAL?
> That is not that heavy as EMBEDDED but expresses this.
>

I, for one, definately think this is a good idea.
Actually, it boggles my mind what this is doing outside of EMBEDDED -
I just noticed it had moved when I build -git4 and oldconfig promted
me about it.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
