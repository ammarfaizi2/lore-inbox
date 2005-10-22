Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbVJVAHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbVJVAHI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 20:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbVJVAHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 20:07:08 -0400
Received: from qproxy.gmail.com ([72.14.204.195]:26485 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965187AbVJVAHG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 20:07:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=itGuR2lzUe0/kdX3xWmx9RDcg2JQXisn8A+Di2wX95vEkjB39pStBlL2XpsvZFlxPPJTj9j9Gipg8l4C90qhSNHgJ1UJCiUpdnXOGMqWipMvA5/GizIcKsFU7+l5NUs5BDAld0Vk7Ie/MqylcFigvJhSBYOrSV4QWGNmEW43eKA=
Message-ID: <9a8748490510211707h20a77cb8q695d1f661537b7fa@mail.gmail.com>
Date: Sat, 22 Oct 2005 02:07:05 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Emmett Lazich <elazich@hutchison.com.au>
Subject: Re: oops on SUSE LES9-SP2-smp on dual EM64T processor system
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1129938390.19857.11.camel@blowy>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1129871849.10237.22.camel@poppy.syd.hutch.com.au>
	 <9a8748490510210331o73b44adr8b3c2f613a3af490@mail.gmail.com>
	 <1129938390.19857.11.camel@blowy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/05, Emmett Lazich <elazich@hutchison.com.au> wrote:
>  Thanks for your thoughts Jesper.  Things are now in progress with
[snip]
>
>  I also thought the age of the kernel version in SUSE Enterprise 9 was a bit
> old. I assume that SuSE maintain their own branch of the 2.6 kernel for E9
> and they will port their fixes into the mainstream kernel at some time
> before they pick a newer kernel as the base source for their next major
> release. A lot of work, but I guess they need control in order to offer paid
> support.
>
I don't run SuSE nor use their kernels, so I can't really say anything
about that, but I assume you are right that they maintain their own
tree and backport fixes.


>  Can you explain for me: With these kernel opps messages, we can see
> register contents and a stack call trace, but it does not (seem) to state
> what actually went wrong.

My Oops reading skills are not the best you can find. Often you can
tell from the oops if it was a null pointer deref or something else
equally obvious - from your oops message I'm only able to see the call
chain and what function eventually caused the oops - you'll neem
someone more skilled than me to actually decipher what exactely went
wrong - sorry.


>Am I right?  If yes, then how can someone resolve
> the fault - particularly after the machine had to be rebooted?
>
I'm pretty sure someone more knowledgable than me can tell more
specifically what went wrong based on that oops.


>  As you might guess, I am a little bit nervous about ever getting a fix for
> this one. Believe me I considered running the newest generic kernel on this
> machine. I was going to use /proc/config.gz then compile from source.  But

That's definately what I'd do.
SuSE/Novell support aside, reproducing the oops with a recent kernel
(taking /proc/config.gz as a base for "make oldconfig") will surely
result in much better response from LKML since very few people care
about problems with as old a kernel as 2.6.5 - but if the bug is
reproducable with the latest stable kernel or the most recent -git
snapshot (or similar) then it's sure to raise eyebrows and get some
attention - and in the end such a bug report (and eventual fix) helps
all of us.


> knowing how SuSE 9E holds together I figured I might be asking for trouble,
> so I shall try it on the model (dev/test) machine first. Even if it works,
> we will then have no support from Novell.

But at least you'll have a working kernel.

Be aware that you may need to upgrade other stuff besides the kernel.
Things change and stuff regularly need updating to keep up. Take a
look at Documentation/Changes in a recent kernel source (the one you
build) to see the minimum requirements for the most basic tools. A new
kernel with out-of-date, known to not work, tools won't win you any
bug reporting prices.


>So I do not know what to think.
> Management as usual need to pay someone for support and to take
> responsibility. But probably get better stability with "community support".
>
I'd say
 a) try the most recent stable kernel.org kernel, see what results you get
 b) see what answer Novell/Suse come up with
Then deside what to do.

Son't be a slave to "only doing it the vendors way" - if the most
recent kernel.org kernel solves the problem but Novell/Suse do not,
then personally I know what I'd use.
If Novell/Suse come up with a fix that makes your support contract
still be valid, then that's probably what you want...

In the end it's your call.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
