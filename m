Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbTGHTPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 15:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267561AbTGHTP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 15:15:29 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:60328 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S267563AbTGHTOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 15:14:38 -0400
Date: Tue, 8 Jul 2003 16:26:31 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: herbert@13thfloor.at, trond.myklebust@fys.uio.no, hannal@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Fastwalk: reduce cacheline bouncing of d_count
 (Changelog@1.1024.1.11)
In-Reply-To: <1057683213.5228.3.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55L.0307081625170.21575@freak.distro.conectiva>
References: <16138.53118.777914.828030@charged.uio.no> 
 <1057673804.4357.27.camel@dhcp22.swansea.linux.org.uk> 
 <16138.56467.342593.715679@charged.uio.no>  <1057677613.4358.33.camel@dhcp22.swansea.linux.org.uk>
  <20030708164426.GB10004@www.13thfloor.at> <1057683213.5228.3.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Jul 2003, Alan Cox wrote:

> On Maw, 2003-07-08 at 17:44, Herbert Poetzl wrote:
> > > Its no big problem to me since I can just back it out of -ac
> >
> > just curious, because I use this patch since early 2.4.20,
> > are there any reasons to 'back it out of -ac' for you?
> >
> > anyway I totally agree that the NFS issue pointed out by
> > Trond should be addressed ...
>
> Its high risk, its got bugs as Trond already showed and it only
> helps performance on giant SMP boxes. Its all risk and no
> reward. Quota updates get you working 32bit uid quota and
> the interactivity stuff helps all even tho its got some
> risk.

Ok, fine. Thats  the feedback I wanted when I included it yesterday.

I'm going to revert it now.

Sorry, Hanna, but Alan saved the day again, and convinced me that fastwalk
is indeed a 2.5 thing.
