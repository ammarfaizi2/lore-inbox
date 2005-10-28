Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbVJ1EAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbVJ1EAq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 00:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbVJ1EAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 00:00:46 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:8379 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965084AbVJ1EAq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 00:00:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=emslsCWpw+kQldWRiedFim/13kvrYUp/o0ryZbRu4/EYFU7aFqhXjEKDTb3dZ6AgpykdWkxBfG0iokIzFB1YWICODgwyDP1sibZuOe1lEi07N3N/7dX/NK99kmF1uG4E6ue3q5xbWQD7E/HCsqnoKEfUhgvnrLV8NVr8O1zUf2Q=
Message-ID: <9a8748490510272100u453e73e3mc957a673eeb8498e@mail.gmail.com>
Date: Fri, 28 Oct 2005 06:00:45 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: The "best" value of HZ
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Claudio Scordino <cloud.of.andor@gmail.com>,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <1130471136.4363.29.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510280118.42731.cloud.of.andor@gmail.com>
	 <200510280331.21112.s0348365@sms.ed.ac.uk>
	 <1130471136.4363.29.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2005-10-28 at 03:31 +0100, Alistair John Strachan wrote:
> > On Friday 28 October 2005 00:18, Claudio Scordino wrote:
> > > Hi,
> > >
> > >     during the last years there has been a lot of discussion about the
> > > "best" value of HZ... On i386 was 100, then became 1000, and finally was
> > > set to 250. I'm thinking to do an evaluation of this parameter using
> > > different architectures.
> > >
> > > Has anybody thought to give the possibility to modify the value of HZ at
> > > boot time instead of at compile time ? This would allow to easily test
> > > different values on different machines and create a table containing the
> > > "best" value for each architecture...  At this moment, instead, we have to
> > > recompile the kernel for each different value :(
> > >
> > > Do you think there would be much work to do that ?
> > > Do you think it would be a desired feature the knowledge of the best value
> > > for each architecture with more precision ?
> >
> > Google for "dynticks". There's obviously an overhead associated with HZ not
> > being a constant (the compiler cannot optimise many expressions), but the
> > feature is being worked on nonetheless.
> >
>
> Well Linus had the best idea in that thread (as usual) which was to
> implement "dynamic ticks" by leaving HZ a constant, setting it to a high
> value, and skipping ticks when idle.  Has there been any work in that
> direction?
>

i did a bit of work in that area, but the stuff I came up with never
seemed to work right, so I dropped it.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
