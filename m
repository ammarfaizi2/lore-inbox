Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293672AbSCFPFe>; Wed, 6 Mar 2002 10:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293668AbSCFPFZ>; Wed, 6 Mar 2002 10:05:25 -0500
Received: from dsl-213-023-039-135.arcor-ip.net ([213.23.39.135]:58538 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S293666AbSCFPFV>;
	Wed, 6 Mar 2002 10:05:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Benjamin LaHaise <bcrl@redhat.com>, Jeff Dike <jdike@karaya.com>
Subject: Re: [RFC] Arch option to touch newly allocated pages
Date: Wed, 6 Mar 2002 15:59:22 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C84F449.8090404@zytor.com> <200203051812.NAA03363@ccure.karaya.com> <20020305133054.B432@redhat.com>
In-Reply-To: <20020305133054.B432@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ict0-0002zT-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 5, 2002 07:30 pm, Benjamin LaHaise wrote:
> On Tue, Mar 05, 2002 at 01:12:19PM -0500, Jeff Dike wrote:
> > Really?  And you're unconcerned about the impact on the rest of the system
> > of a UML grabbing (say) 128M of memory when it starts up?  Especially if it
> > may never use it?
> 
> Honestly, I think that most people want to know if the system they've setup 
> is overcommited at as early a point as possible: a UML failing at startup 
> with out of memory is better than random segvs at some later point when the 
> system is under load.  Refer to the principle of least surprise.  And if the 
> user truely wants to disable that, well, you can give them a command line 
> option to shoot themselves in the foot with.

Suppose you have 512 MB memory and an equal amount of swap.  You start 8
umls with 64 MB each.  With your and Peter's suggestion, the system always
goes into swap.  Whereas if the memory is only allocated on demand it
probably doesn't.

-- 
Daniel
