Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVI0DuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVI0DuP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 23:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVI0DuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 23:50:15 -0400
Received: from nproxy.gmail.com ([64.233.182.200]:5042 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750834AbVI0DuO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 23:50:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T2de5Y1LTjb7GPL5gYp2LjerzCfVgZdqF6Gmiydw+WTNQlFaD0U6mlq4ewfz+E0FeWKG+A2rwkGSIaGl8wpMKIeyoRyoDZ+pDOoY91GK2VYT8RycPBu/fX85/q7Y9GbFQHP8iP7tXco6dtUljPrdOlLzHO9oN0UQetTuH6efB/Q=
Message-ID: <2cd57c9005092620504c269a45@mail.gmail.com>
Date: Tue, 27 Sep 2005 11:50:13 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Roger Heflin <rheflin@atipa.com>
Subject: Re: Resource limits
Cc: Al Boldi <a1426z@gawab.com>, linux-kernel@vger.kernel.org
In-Reply-To: <EXCHG2003ogxLDp7mvj00000ae4@EXCHG2003.microtech-ks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509251712.42302.a1426z@gawab.com>
	 <EXCHG2003ogxLDp7mvj00000ae4@EXCHG2003.microtech-ks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/05, Roger Heflin <rheflin@atipa.com> wrote:
>
> While talking about limits, one of my customers report that if
> they set "ulimit -d" to be say 8GB, and then a program goes and
> attempts to allocate 16GB (in one shot), that the process will
> hang on the 16GB allocate as the machine does not have enough
> memory+swap to handle this, the process is at this time unkillable,
> the customers method to kill the process is to send the process
> a kill signal, and then create enough swap to be able to meet
> the request, after the request is filled the process terminates.
>
> It would seem that the best thing to do would be to abort on
> allocates that will by themselves exceed the limit.
>
> This was a custom version of a earlier version of the 2.6 kernel,
> I would bet that this has not changed in quite a while.
>
>                         Roger

It's simple. Set /proc/sys/vm/overcommit_memory to 2 (iirc) to get
arround this `bug' .
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
