Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWCVUFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWCVUFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWCVUFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:05:38 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:39603 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750834AbWCVUFi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:05:38 -0500
Subject: Re: gettimeofday order of magnitude slower with pmtimer, which is
	default
From: john stultz <johnstul@us.ibm.com>
To: Avi Kivity <avi@argo.co.il>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Con Kolivas <kernel@kolivas.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com
In-Reply-To: <4421A18F.4040600@argo.co.il>
References: <20060320122449.GA29718@outpost.ds9a.nl>
	 <20060320145047.GA12332@rhlx01.fht-esslingen.de>
	 <200603210224.23540.kernel@kolivas.org>
	 <87wteo37vr.fsf@duaron.myhome.or.jp>	<1142968999.4281.4.camel@leatherman>
	 <8764m7xzqg.fsf@duaron.myhome.or.jp>  <4421A18F.4040600@argo.co.il>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 12:05:30 -0800
Message-Id: <1143057931.13152.2.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 21:12 +0200, Avi Kivity wrote:
> OGAWA Hirofumi wrote:
> > john stultz <johnstul@us.ibm.com> writes:
> >
> >   
> >> In my TOD rework I've dropped the triple read, figuring if a problem
> >> arose we could blacklist the specific box. This patch covers that, so it
> >> looks like a good idea to me.
> >>
> >> I've not tested it myself, but if you feel good about it, please send it
> >> to Andrew.
> >>     
> >
> > Current patch is the following. If I'm missing something, or you have
> > some comment, please tell me. (Since I don't have ICH4, ICH4 detection
> > is untested)
> >   
> Doesn't it make sense to mark the port as user accessible in the I/O 
> permissions bitmap and export it as a vsyscall? that would save the 
> syscall overhead.

i386 doesn't yet have a vsyscall gtod. I had some code around earlier
for it, but it still needed a good bit of work before it would be ready
for mainline. If you're interested in working on this, I'd be happy to
send them to you.

thanks
-john

