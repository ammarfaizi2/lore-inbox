Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVGXNBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVGXNBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 09:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVGXNBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 09:01:25 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:19560 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261935AbVGXNBX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 09:01:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W0qpfAwnItskil5yEqj4MkcpG8r+QVgy8x41zXml+pr3b1YyV3zpOTR1aKEAkgTkIC5DUCWIgeaKthJK2cpjZgB5hH4ZevK3MQYXmR7WvDaz0XjBkaINxJ22ZjpfHvwqbqX5t1eaev+HvqbFx8xtRrsIPcx4i34M7x+8DjFHX1c=
Message-ID: <9a8748490507240601ec7a940@mail.gmail.com>
Date: Sun, 24 Jul 2005 15:01:22 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: lkml@dodo.com.au
Subject: Re: 2.6.13-rc3 test: finding compile errors with make randconfig
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <f8b6e1h2t4tlto7ia8gs8aanpib68mhit6@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <f8b6e1h2t4tlto7ia8gs8aanpib68mhit6@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/05, Grant Coady <lkml@dodo.com.au> wrote:
> Greetings,
> 
> Few days ago I compiled 241 random configurations of 2.6.13-rc3, today
> I finally got around to parsing the results, top 40, sorted by name.
> Percentage is error_builds / total_builds.
> 
> build script similar to:
> count=0
> while [ $((++count)) -le $limit ]; do
>         trial=$(printf %003d $count)
>         make randconfig
>         cp .config "$store/$trial-config"
>         make clean
>         make -j2 2> "$store/$trial-error"
> done
> 
> Curious whether this is worth doing, I'm about to start a run for 2.6.12.3,
> any interesting errors I can find the particular config + error to recover
> context.  Deliberately simplistic for traceability at the moment, truncated
> error length for this post.
> 
If you could put the data online somewhere I'd be interrested in
taking a look at it.
An easy way to look at the build log and grab the matching .config for
any given run would be great.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
