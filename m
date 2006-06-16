Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWFPFtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWFPFtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 01:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWFPFtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 01:49:03 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:33465 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751032AbWFPFtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 01:49:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hVbQEOW72JRJ9AngyZ0Lx1V7O/afh3gCUH6CYnxx+xo6MPkIzKEjBWf61XVJfWDC52I7jBh/qsmJPHopvFG+ftyQGp6AaZIiu+VO9OMJmr2TfYl+c6dBbOItdYeDDqOIgV53Ig4f78IsUlghocIVv/0rt15jXQFCAzyO08dMrg8=
Message-ID: <ef5305790606152249n2702873fy7b708d9c47c78470@mail.gmail.com>
Date: Fri, 16 Jun 2006 17:49:00 +1200
From: "Goo GGooo" <googgooo@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: 2.6.17-rc6-mm2
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606151937360.5498@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com>
	 <ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com>
	 <Pine.LNX.4.64.0606151937360.5498@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/06, Linus Torvalds <torvalds@osdl.org> wrote:

> So to recap:
>  - http is fundamentally weaker, and needs some server-side help to work
>  - rsync is fine for the initial clone, but doesn't actually know what
>    it's doing, so the end result can actually even be a corrupted
>    repository, because you happened to rsync just as it was updating.
>  - the native git protocol generally should be considered the golden
>    standard, where the other ones are just fallbacks in case of problems
>    (like firewalls that don't let git:// through, or more commonly hosted
>    servers that don't do the git protocol at all).
>
> Which hopefully clarifies the issue a bit.

Thanks for explanation. Unfortunately I can't use git:// with "git
pull" (at least in git-1.3.2). First it does some traffic, that
suddenly stops - I guess the server starts doing *something*, perhaps
preparing the update for me or whatnot. After a pretty long while it
sends some more data but in the meanwhile my ADSL router dropped the
NAT entry and git sits on my side waiting for data forever. Recently I
tried the same on a system with direct Inet connection and that worked
just fine.

I suggest adding SO_KEEPALIVE option on the git socket.

Goo
