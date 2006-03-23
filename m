Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWCWMhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWCWMhS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 07:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWCWMhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 07:37:18 -0500
Received: from anubis.pendulus.net ([38.119.36.60]:1734 "EHLO
	anubis.pendulus.net") by vger.kernel.org with ESMTP id S932267AbWCWMhQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 07:37:16 -0500
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproductions.com
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [ck] 2.6.16-ck1
Date: Thu, 23 Mar 2006 07:37:20 -0500
User-Agent: KMail/1.9.1
Cc: Rodney Gordon II <meff@pobox.com>,
       linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>
References: <200603202145.31464.kernel@kolivas.org> <20060323113118.GA9329@spherenet.spherevision.org> <cone.1143114017.303805.31285.501@kolivas.org>
In-Reply-To: <cone.1143114017.303805.31285.501@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603230737.20901.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con,

I believe the author of that readahead patch stated that using the following 
below would help in desktop usage :: 

/sbin/blockdev --setra 256 /dev/XXX



On Thursday 23 March 2006 6:40 am, Con Kolivas wrote:
> Rodney Gordon II writes:
> > Good job Con, on your patches.. As far as the kernel in general, I'd
> > like to post some warnings:
>
> Thanks.
>
> > Adaptive readahead: I had probs with this before, and I still do.. On
> > a desktop if you have odd problems (nothing responding for SECONDS,
> > very slow disk I/O during heavy I/O, etc..) disable it.
>
> I was concerned about that myself which is why the only reason I included
> it was because it came in a configurable form where you could choose to
> enable it, and the default was off, and the config option even said
> suitable to _servers_, not desktops.
>
> > The new Yukon2 "sky2" driver: This one really pissed me off. It had me
> > thinking apache2 AND my linksys router we're on the brink. For some
> > unknown reason at least for me, in FF it would only half-load some
> > pages, including ones on localhost AND my router (10.1.1.1) ... I
> > dunno what the hell is up with this one. I have to stay with the
> > syskonnect.com sk98lin patch, which.. doesn't work with 2.6.16 so I am
> > back to 2.6.15 at the moment.
> >
> > nVidia drivers: Broken. I posted a ftbfs bug on the debian bts, here
> > is a current patch that works against the current release:
> > http://bugs.debian.org/cgi-bin/bugreport.cgi/nvidia-kernel-source_1.0.817
> >8-2.diff?bug=357992;msg=15;att=1
>
> Luckily none of these are my fault.
>
> > All in all, my experience sucked for the first time on this kernel.
>
> /me does the "not my fault" look.
>
> > Good luck with this new one..
>
> Heh. No new one in the works just yet, but I'm actually not planning on
> changing anything. Turn adaptive readahead off, and you're left with out of
> kernel tree, or worse, binary driver problems.
>
> Cheers,
> Con
