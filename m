Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSHBQjM>; Fri, 2 Aug 2002 12:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315513AbSHBQjK>; Fri, 2 Aug 2002 12:39:10 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:39420 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316070AbSHBQjF>; Fri, 2 Aug 2002 12:39:05 -0400
Subject: Re: adjust prefetch in free_one_pgd()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: davidm@hpl.hp.com
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       davidm@napali.hpl.hp.com
In-Reply-To: <15690.46452.806917.37660@napali.hpl.hp.com>
References: <Pine.LNX.4.44.0208020844000.18265-100000@home.transmeta.com>
	<1028310567.18635.87.camel@irongate.swansea.linux.org.uk> 
	<15690.46452.806917.37660@napali.hpl.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Aug 2002 18:58:53 +0100
Message-Id: <1028311133.18317.96.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 17:38, David Mosberger wrote:
> >>>>> On 02 Aug 2002 18:49:27 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> said:
> 
>   Alan> I can't think of anything cachable with nasty side effects we
>   Alan> might encounter right now but one day someone will do it just
>   Alan> to be annoying.
> 
> Cacheable and side-effects don't go together.  Even without explicit
> software prefetches, most modern CPUs will happily and aggressively
> prefetch stuff from cacheable translations.

Yes we got burned on that with the latest AMD processors. They prefetch
into an area we accidentally have marked with differing cachabilities
between kernel and user space when using the nv binary driver stuff (but
its our bug not theirs). There's a horrid hack in 2.4.19rc to deal with
it pending merging the proper patches


