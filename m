Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316255AbSEQO4a>; Fri, 17 May 2002 10:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316256AbSEQO43>; Fri, 17 May 2002 10:56:29 -0400
Received: from host194.steeleye.com ([216.33.1.194]:3595 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S316255AbSEQO42>; Fri, 17 May 2002 10:56:28 -0400
Message-Id: <200205171456.g4HEuKf02281@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Miles Lane <miles@megapathdsl.net>
cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 May 2002 10:56:20 -0400
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Along the same lines, we have James Bottomly attempting to  get
> support for the NCR Voyager architecture added to the kernel.  His
> original submission post was sent 2001-12-23: http://
> marc.theaimsgroup.com/?l=linux-kernel&m=100913508007485&w=2 The latest
> submission attempt was sent 2002-05-11: http://marc.theaimsgroup.com/
> ?l=linux-kernel&m=102115570805131&w=2

> It seems to me that adding a new architecture probably doesn't impact
> the rest of the kernel much, so I am not sure way  acceptance would be
> so long delayed.  I have noticed that  there has been minimal feedback
> to James, which he appears to have responded to quickly and well.  I
> tend to think that any tweaks needed could be accomplished as easily
> once the code has been accepted into the kernel tree.

> Is there some justification for the delay that I have somehow
> overlooked?

Actually, the major criticism was that a new architecture can't be wedged into 
the arch/i386 directory without changing an awful lot of critical files, which 
is true (and also undesirable from a QA standpoint).

I addressed that by doing the i386 subarchitecture rework (which allows me to 
slide all the voyager stuff in to the side). However, that still does a 
hatchet job on arch/i386.  There are also several other people working on 
related issues in arch/i386, so it has become a slow job.  The current status 
is

- PCI rework - In Linus Kernel
- setup/cpu rework - in DJ kernel

I get to wait until the setup/cpu rework makes it to the Linus kernel so I can 
slot in the arch subdivisions around it.

James


