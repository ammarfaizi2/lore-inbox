Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVGTBcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVGTBcK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 21:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVGTBcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 21:32:10 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:57455 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261213AbVGTBcI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 21:32:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LWGVEAi9GEIdI/x2yJ/+ZeZ+M2ZbPrBgcYMQQgeTIe9ndh0hS0P0hhZqMgeciOzRNIjlN44ZHPKyIX1IhWAB7T7yleP+9m1LZwbNHVYqfrJMOjU8qOehFxz8D7vd/rpgrL4S/Q4yDAMJ1G9kydn+eRahEstd/jkisY+lHGKPv7M=
Message-ID: <9a8748490507191831267b17d9@mail.gmail.com>
Date: Wed, 20 Jul 2005 03:31:41 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: dwalker@mvista.com
Subject: Re: Interbench real time benchmark results
Cc: Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <1121822524.26927.85.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507200816.11386.kernel@kolivas.org>
	 <20050719223216.GA4194@elte.hu>
	 <1121819037.26927.75.camel@dhcp153.mvista.com>
	 <200507201104.48249.kernel@kolivas.org>
	 <1121822524.26927.85.camel@dhcp153.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/05, Daniel Walker <dwalker@mvista.com> wrote:
> On Wed, 2005-07-20 at 11:04 +1000, Con Kolivas wrote:
> > On Wed, 20 Jul 2005 10:23 am, Daniel Walker wrote:
> > > On Wed, 2005-07-20 at 00:32 +0200, Ingo Molnar wrote:
> > > >  - networking is another frequent source of latencies - it might make
> > > >    sense to add a workload doing lots of socket IO. (localhost might be
> > > >    enough, but not for everything)
> > >
> > > The Gnutella test?
> >
> > I've seen some massive latencies on mainline when throwing network loads from
> > outside, but with my limited knowledge I haven't found a way to implement
> > such a thing locally. I'll look at this gnutella test at some stage to see
> > what it is and if I can adopt the load within interbench. Thanks for the
> > suggestion.
> 
> There isn't actually a test called "The Gnutella test" , but I think
> Gnutella clients put lots of network load on a system (Lee was talking
> about that not to long ago). I was thinking that type of load may have
> been what Ingo was talking about.
> 
If you want to generate a lot of network related interrupts, wouldn't
a much simpler way to do that be a simple

  ping -f targetbox 

from a host connected to `targetbox' via a crosswired ethernet cable
or a fast switch..?

Also easy to modify the size of the ping packets if you want to.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
