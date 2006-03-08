Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWCHDEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWCHDEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWCHDEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:04:30 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:19043 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964883AbWCHDE3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:04:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gCgO14tugUqv6BP4V9csspZgkYcfnmrY5ipxcvB43GffgaA+/1voMuvz27OMoAxrgN8CeukEVEm2+ZMetdizG/1dpNgbxCw2ei0Z2pTdKcxMAmbfrEhzKE0/3LccIEbMgTLCU7NYG1yhRgpvcnR0zUEfhum6wN97XY37064XT5Y=
Message-ID: <aec7e5c30603071904x617f2897l7f9f8e4b444a6cc3@mail.gmail.com>
Date: Wed, 8 Mar 2006 12:04:28 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Linda Walsh" <lkml@tlinx.org>
Subject: Re: FWIW: Re: SMP and 101% cpu max?
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <440E467D.70804@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <aec7e5c30603070434j7f326ad2r5f1b0e8046870941@mail.gmail.com>
	 <9a8748490603070507h48e2fe02qbf9da7956e794161@mail.gmail.com>
	 <440E467D.70804@tlinx.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/06, Linda Walsh <lkml@tlinx.org> wrote:
> FYI, running/compiling 2.6.15.5 on a 2x(1GHzxP-III), 1GB
> times for "make" -jn bzImage (no modules):
> (using export TIMEFORMAT="%2Rsec %2Uusr %2Ssys (%P%% cpu)" )
>
> -j1: 815.80sec 745.64usr 78.74sys (100.00% cpu)
> -j2: 445.17sec 778.68usr 86.22sys (100.00% cpu)
> -j3: 444.89sec 781.66usr 87.84sys (100.00% cpu)
> -j4: 443.08sec 781.81usr 87.97sys (100.00% cpu)
> -j5: 445.98sec 782.53usr 87.51sys (100.00% cpu)
> -----
>
> I am not seeing the symptom you are describing.  The load
> increases proportionately to the 'job limit', but it doesn't
> radically change the overall cpu required.  As I have
> only 2 cpu's, I can't expect much benefit beyond 2x, with
> actual approaching closer to 1.8x.

Yes, that's what I'm expecting to see. And I do see similar results
for 2.6.15. But it looks like 2.6.16-rc6 is misbehaving somehow.

Thanks,

/ magnus

> -l
>
>
> Jesper Juhl wrote:
> > On 3/7/06, Magnus Damm <magnus.damm@gmail.com> wrote:
> >
> >> With 128MB and 256MB configurations, a majority of the tests never
> >> make it over 101% CPU usage when I run "make -j 2 bzImage", building a
> >> allnoconfig kernel. With 64MB memory, everything seems to be working
> >> as expected. Also, running "make bzImage" works as expected too.
> >>
> > Hmm, I wonder if it's related to the problem I reported here :
> > http://lkml.org/lkml/2006/2/28/219
> > Where I need to run make -j 5 or higher to load both cores of my Athlon X2.
> >
>
