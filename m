Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423833AbWKHWkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423833AbWKHWkc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423837AbWKHWkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:40:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:18839 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423833AbWKHWka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:40:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P8Z8SCMhUBA+dDRN9LNZY97KBlVbVi7WpM2nECUSNRkhLNIkcDbgxfQOPPMZOKGALTx114pVEbg3UJ0V63GnAGCcUlPEle9t45GMaJpRfvhPhFOI+qFLo1PWLjG04GWYFCmBtWpIRJi92+o28Sfntheoh9WhyeLoLLuFE893uHk=
Message-ID: <9a8748490611081440u6ba6c541h1038ac1e530e2839@mail.gmail.com>
Date: Wed, 8 Nov 2006 23:40:27 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Adrian Bunk" <bunk@stusta.de>
In-Reply-To: <1163024531.3138.406.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490611081409x6b4cc4b4lc52b91c7b7b237a6@mail.gmail.com>
	 <1163024531.3138.406.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/06, Arjan van de Ven <arjan@infradead.org> wrote:
>
> > There's no shortage of issues that need fixing, but since we keep
> > merging new stuff, a lot of bugfixing energy gets spend on the new
> > cool stuff instead of fixing up any other issues we have.
>
> but if you do this you just end up with a bigger backlog so that the
> next one will even be more unstable due to a extreme high change rate.
>
Only if people continue to work on new stuff during the "bug fixing only" cycle.
If we manage to get everyone focused on bug fixing only for the entire
cycle the backlog won't be growing (much).

>
> > Coverity has, as of this writing, identified 728 issues in the current
> > kernel. Sure, some of those have already been identified as false or
> > ignorable issues, but many are flagged as actual bugs and still more
> > are as yet uninspected.
>
> most are mostly false. And the rest is getting looked at. What's the
> problem?
>
Yes, MANY are false, and I know the rest are getting worked at, I work
on some myself when time permits.
I mentioned it simply as an indicator (one amongst many) that we have
a lot of known unfixed issues.


> > Adrian Bunk has his list of known regressions and, I'll bet, also some
> > patches in the trivial queue for small issues.
>
> and all this fixing is happening AS WELL as new features. What makes you
> think suddenly even more fixing will happen?
>
My point was "get people to suspend their work on new features and
focus entirely on bugfixes for a single cycle", so we get more
manpower working on fixing all those known issues we have before we
move on with new features.


> > There are many parts of the kernel that are not documented.
>
> this is where the OSDL Documentation Person will help a lot; a full time
> person.
>
True. I'm looking forward to that.


>
> > I'm sure most distributions have a bunch of bug fixing patches lying
> > about that they could push.
>
> I doubt it; most have gotten real good at avoiding getting a huge patch
> backlog since that is just incredibly expensive ;)
>
Ok, maybe I was wrong there.


> > - A while back, akpm made some statements about being worried that the
> > 2.6 kernel is getting buggier
> > (http://news.zdnet.com/2100-3513_22-6069363.html).
>
> and at this years Kernel Summit actual data and general consensus showed
> this was unfounded fear; the bugrates are more or less stable, but with
> many more users.
>
Ok, I may be on thin ice here, but that contradicts my personal
experience. I see a lot of very nice improvements in recent 2.6
kernels, but I also see a greater need for careful testing before
deploying on the systems I'm responsible for - I feel that I'm running
into more "whoops that kernel wasn't quite fully baked" situations
recently (and yes, I do try to report and/or fix those issues when I
encounter them).


> >
> > - The need for the -stable tree and the (relatively large) number of
> > -stable releases between each new major release clearly shows that we
> > are leaving lots of regressions in our wake.
>
> No it shows that bugs are getting fixed and delivered to you
> IMMEDIATELY. Many many of the -stable things fixed are not in new
> things. Is there anything in the -stable process that is not working for
> you?
>
Let me make one very clear statement first: -stabel is a GREAT think
and it is working VERY well.
That being said, many of the fixes I see going into -stable are
regression fixes. Maybe not the majority, but still, regression fixes
going into -stable tells me that the kernel should have seen more
testing/bugfixing before being declared a stable release.

All I'm trying to say is that we have a number of known bugs, a number
of known regressions, a number of known inefficiencies. Maybe, just
maybe, we should focus a little more on that and a little less on new
features, new hardware support etc. Not permanently - overall I think
the 2.6 model is working great - but just for a single kernel release
cycle every now and then.  And why not just try it once as an
experiment? We'll never know if it's a good idea if we don't try it at
least once.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
