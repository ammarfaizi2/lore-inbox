Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313424AbSDLHox>; Fri, 12 Apr 2002 03:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313428AbSDLHow>; Fri, 12 Apr 2002 03:44:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62274 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313424AbSDLHou>; Fri, 12 Apr 2002 03:44:50 -0400
To: Blue Lang <blue@b-side.org>
Cc: Michael De Nil <linux@aerythmic.be>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: i830M video chip (X driver deficient)
In-Reply-To: <Pine.LNX.4.30.0204111625260.17120-100000@gib.soccerchix.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Apr 2002 01:37:49 -0600
Message-ID: <m18z7tl642.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blue Lang <blue@b-side.org> writes:

> On Thu, 11 Apr 2002, Michael De Nil wrote:
> 
> > i searched on the intel-website, which told me hat i should be able to
> > change this setting in my bios. *not*
> >
> > can't i reserve any more ram myselve by selecting linux only to use 256 -
> > 8 Meg or something @ boot-time ?
> 
> the dell c400 has this same problem. there is an excellent web page on one
> person's experiences with it, but i can't find it right now.. anyways, his
> result was that the bios was actually broken and that it would take a f/w
> update from Dell to fix it. a little googling should yield the results you
> want.
> 
> i assume it's probably the same situation with your laptop.

It isn't memory related at all.  The problem is that the X driver uses 
the video BIOS to set the display modes, instead of setting the
display mode by itself as it should.  I don't know if there are enough
docs available from intel about this but that is the problem.

I have a coworker with one of these and I tracked problem down that
far.  With agpgart the kernel allocates the rest of the memory for X
as needed.

Eric
