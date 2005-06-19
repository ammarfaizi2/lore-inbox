Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVFSUTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVFSUTe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 16:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVFSUTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 16:19:34 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:49536 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261315AbVFSUT3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 16:19:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A3xMsT/rvPV5yQugXvLfvtbXHIQynDY4/jgzXuwag4qW2DWJU1xTyA/QW181hKgxbxgqZ9o/tx0Wsolde9fopUXx4EqkSrK+OzOsYVabdTW9KLhjJewEGFZIi30umWuLXQ4ReICef57gfJSP8o3PrOorTHYTXwbPm67Vfmdlgf0=
Message-ID: <9a874849050619131941278fc4@mail.gmail.com>
Date: Sun, 19 Jun 2005 22:19:26 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] Small kfree cleanup, save a local variable.
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       "Rickard E. (Rik) Faith" <faith@redhat.com>,
       Rik Faith <faith@cs.unc.edu>, linux-audit@redhat.com
In-Reply-To: <20050619201354.GY9153@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.62.0506192129300.2832@dragon.hyggekrogen.localhost>
	 <20050619201354.GY9153@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/05, Chris Wright <chrisw@osdl.org> wrote:
> * Jesper Juhl (juhl-lkml@dif.dk) wrote:
> > Here's a patch with a small improvement to kernel/auditsc.c .
> > There's no need for the local variable  struct audit_entry *e  ,
> > we can just call kfree directly on container_of() .
> > Patch also removes an extra space a little further down in the file.
> 
> Please Cc: linux-audit@redhat.com on audit patches.

I didn't find that address in MAINTAINERS nor in the source file. I
had no idea it existed. Perhaps it ought to be listed in MAINTAINERS
somewhere...


>  I tend to agree
> with Michael, it's optimized away, and readable as is.
> 
Fair enough, we'll just leave it as is :)


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
