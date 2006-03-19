Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWCSBBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWCSBBx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 20:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWCSBBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 20:01:53 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:27062 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751186AbWCSBBw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 20:01:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UifWgT51maZE2LUubR8RHwVEkQ3Q6BPKVBVYvMXQ2PXLcMH0h1G2qe0fg7lz/eYWgxdyWARSU8tp34eBb7NLXAg37GfEggxqebc1NaQcKZL13ANe0d2nFXFx2Tk3ATfteYhfIM5iQCa4o6FaB5FkzK++WY7tXxu8sEkHYi4oJaw=
Message-ID: <9a8748490603181701k7e63827bib0868611602e0db7@mail.gmail.com>
Date: Sun, 19 Mar 2006 02:01:51 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Al Viro" <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Fix a potential NULL pointer deref in znet
Cc: linux-kernel@vger.kernel.org, becker@scyld.com
In-Reply-To: <20060319004639.GY27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603190112.31828.jesper.juhl@gmail.com>
	 <20060319004639.GY27946@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> On Sun, Mar 19, 2006 at 01:12:31AM +0100, Jesper Juhl wrote:
> >
> > The coverity checker spotted that we dereference a pointer before we check it
> > for NULL in drivers/net/znet.c::znet_interrupt().
> > This fixes the issue.
>
> The hell it does.  Either interrupt really isn't shared, in which case
> this check should be simply removed, or it can be shared, in which case
> the code is still buggered.
>
> Please, stop pulling Bunk - _think_ before submitting "make <program> STFU"
> patches.
>

Believe it or not,  but I actually do try to think about the patches I submit.
I make mistakes sometimes and I don't know all the code in as much
depth as I would like, but I do try to help out the best I can.

I appreciate feedback on the work I do, and I try to improve based on
it - this means I also value your feedback although I must say I
dislike your tone.

I'll stare at the code some more and try to come up with a better
patch after I've had some sleep.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
