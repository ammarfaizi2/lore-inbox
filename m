Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbULJEiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbULJEiN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 23:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbULJEiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 23:38:13 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:4394 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261555AbULJEiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 23:38:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=qRBb1CpTMnbCmDyCICl4we8yehGmTqcQ8xe5yX8lQSYUOHBJTmlS0RkvQE9XAfmL0DJaE68kwxzlFm6m7EFWiXrBWmKSvw5p5KuvfOjDsmB43GZxWsaRMWvjYl/H34K0lKHemvHp112LiwOpQyCRuwXLrCffeWhSDibFpCB/Os8=
Message-ID: <f2833c7604120920386e790b26@mail.gmail.com>
Date: Fri, 10 Dec 2004 04:38:05 +0000
From: Timothy Chavez <chavezt@gmail.com>
Reply-To: Timothy Chavez <chavezt@gmail.com>
To: Robert Love <rml@novell.com>
Subject: Re: [audit] Upstream solution for auditing file system objects
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       sds@epoch.ncsc.mil, ttb@tentacle.dhs.org
In-Reply-To: <1102650138.6052.228.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <f2833c760412091602354b4c95@mail.gmail.com>
	 <20041209174610.K469@build.pdx.osdl.net>
	 <f2833c76041209185024cb1c4d@mail.gmail.com>
	 <1102650138.6052.228.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Dec 2004 22:42:18 -0500, Robert Love <rml@novell.com> wrote:
> On Fri, 2004-12-10 at 02:50 +0000, Timothy Chavez wrote:
> 
> Hi, Timothy.  You work for IBM?
>

Yep.
 
> 
> 
> > Some way for inotify to "notify" other parts of the kernel of file
> > system activity would be good.  This is the arguement I'd like to use.
> >  If inotify can notify userspace apps of activity/events, why can't it
> > notify kernel subsystems?  There might be a very good reason as to why
> > this can't be so.  "Just because" might be it :-) Whatever the reason,
> > it'd be good to hear.  I wouldn't want to destroy or degrade the
> > intended use of inotify, but expand it.  If that's not doable, then
> > there's no way we can use inotify.  This would have to be something
> > John and Rob and whoever else contributes to Inotify would like in
> > addition to the community as a whole.
> 
> I do not think it makes any sense for inotify to be the mechanism that
> implements auditing.  What you want is a general file event mechanism at
> the level and time that we currently do the inotify hooks.  I agree,
> that is good.  What you also want is to do is hack into inotify your
> auditing code.  I don't like that--I don't want inotify to grow into a
> generic file system tap.

Fair enough.  I agree that having something more generic at the hook
level would be ideal.  I'm interested in what others might think about
this.
 
> What we both need, ultimately, is a generic file change notification
> system.  This way inotify, dnotify, your audit thing, and whatever else
> can hook into the filesystem as desired.

> Subverting the inotify project to add this functionality now will only
> hurt inotify.  We are not yet in the kernel and we need to streamline
> and simplify ourselves, not bloat and featurize.  Besides, indeed, we
> are not in the kernel yet--you can just as easily add the hooks
> yourself.

Right, but we like inotify and want to see it succeed :-)!  We also
want an upstream solution, so playing nicely is essential.

> So my position would be that I am all for moving the inotify hooks to
> generic file change hooks, but that needs to be done either once inotify
> is in the kernel proper or as a separate project.  Then inotify can be
> one consumer of the hooks and auditing another.

It's a reasonable compromise and it'll have to be considered and discussed.
 
> If you want to move forward with a project to hook file system events,
> go for it.  Regardless, I think that you should post to lkml your
> intentions.

Most definately.  Thanks for the reply.
 
> Best,
> 
>         Robert Love
> 
> 

-- 
- Timothy R. Chavez
