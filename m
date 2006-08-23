Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWHWRY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWHWRY0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 13:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWHWRY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 13:24:26 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:16872 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932324AbWHWRYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 13:24:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rLmkliQ3NyK/PtlBNkBxDXNdOjsZJu3etlXBz9UeDxxdFjcpTcx6XpdNgLzeb6VJjY8OvBKkBGzgOG4QjuGephI6rpnE1l3RYvdDQXtHbE94k+boUPtPHuffzG/SCDdeAWRZnzv7oO+O3ttptGUW/UtjPtvoR3CilkNCDD8zORs=
Message-ID: <e6babb600608231024u3b5462d2oecc940f670516405@mail.gmail.com>
Date: Wed, 23 Aug 2006 10:24:24 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "hui Bill Huey" <billh@gnuppy.monkey.org>
Subject: Re: rtmutex assert failure (was [Patch] restore the RCU callback...)
Cc: "Esben Nielsen" <nielsen.esben@googlemail.com>,
       "Ingo Molnar" <mingo@elte.hu>, "Thomas Gleixner" <tglx@linutronix.de>,
       rostedt@goodmis.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <e6babb600608231014r23886965k9cbc1fd3b80930bb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060811010646.GA24434@gnuppy.monkey.org>
	 <20060811221054.GA32459@gnuppy.monkey.org>
	 <e6babb600608141056j4410380fr15348430738c91d8@mail.gmail.com>
	 <20060814234423.GA31230@gnuppy.monkey.org>
	 <e6babb600608151053u6b902b80k9e3b399fe34ee10f@mail.gmail.com>
	 <20060818115934.GA29919@gnuppy.monkey.org>
	 <e6babb600608211721g739c5518sa14427d1e9f2334@mail.gmail.com>
	 <20060822013722.GA628@gnuppy.monkey.org>
	 <20060822232051.GA8991@gnuppy.monkey.org>
	 <e6babb600608231014r23886965k9cbc1fd3b80930bb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/06, Robert Crocombe <rcrocomb@gmail.com> wrote:
> On 8/22/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
> > I turned off the tracing in the latency tracking stuff and a relatively
> > small patch is here against -rt8:
> >
> >         http://mmlinux.sourceforge.net/public/against-2.6.17-rt8-0.diff
>
> I'm going to assume that the #error here:
>
> +#ifdef CONFIG_LATENCY_TRACE
> +#error
> +       stop_trace();
> +#endif
>
> is to see if I'm awake.  No, but gcc is.  I just removed it (?).

Just in case it was a "hey, dummy, don't do that" kind of thing, I
built another kernel with latency tracing off, but the end result is
the same.

-- 
Robert Crocombe
rcrocomb@gmail.com
