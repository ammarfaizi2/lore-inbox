Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbULUScx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbULUScx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 13:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbULUScb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 13:32:31 -0500
Received: from web52601.mail.yahoo.com ([206.190.39.139]:14449 "HELO
	web52601.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261832AbULUScQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 13:32:16 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=6Fonl/YnTp00qVWF/ZS9LNZLf0RwzC5apZWEp/OYYlPHfBLiTksWu5SfF1tpels+Adn06tjh6s3vLNTnUVbUrH9wC+QHPiQ1vOr1cpj0WiJjg9p0RHM/v7CbArec1n7pv0K6ntrdHyPuVUOuByuts6DYaitcd39LDZ8LsTP3wWA=  ;
Message-ID: <20041221183216.56558.qmail@web52601.mail.yahoo.com>
Date: Tue, 21 Dec 2004 10:32:16 -0800 (PST)
From: jesse <jessezx@yahoo.com>
Subject: Re: Gurus, a silly question for preemptive behavior
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cone.1103608791.326982.28853.502@pc.kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con:

   thank you for your prompt reply in the holiday
season. 

   My point is: Even kernel 2.4 is not 
preemptive, the latence should be very
minimal.(<300ms)
why user space application with low nice priority
can't be effectively interrupted and holds the CPU
resource since all user space application is
preemptive?

   Merry Xmas.

jesse

  

--- Con Kolivas <kernel@kolivas.org> wrote:

> jesse writes:
> 
> >  
> > As i know, in linux, user space application is
> > preemptive at any time. however, linux kernel is
> NOT
> > preemptive, that means, even some event is
> finished,
> > Linux kernel scheduler itself still can't have
> > opportunity to interrupt the current user
> application
> > and switch it out. it is called scheduler latency.
> 
> The kernel is preemptible if you enable the preempt
> option in the 
> configuration. There are some code paths that are
> not preemptible despite 
> this, but they are gradually being improved over
> time.
> 
> > normally , the latency is about 88us in mean ,
> maximum
> > : 200ms. Thus, the short latency shouldn't impact
> user
> > applications too much and is not a problem. It is
> an
> > issue in those embedded voice processing systems
> by
> > introducing jitters, thus smart people came up
> with
> > two kernel schedule patch: preemptive patch and
> low
> > latency patch. 
> 
> You're thinking about the 2.4 kernel. 2.6 is
> effectively both of those 
> patches inclusive.
> 
> > my system: 
> > [root@sa-c2-7 proc]# uname  -a 
> > Linux sa-c2-7 2.4.21-15.ELsmp #1 SMP Thu Apr 22
> > 00:18:24 EDT 2004 i686 i686 i386 GNU/Linux 
> 
> If you want lower latency on a 2.4 kernel you need
> further patches. You are 
> most likely to benefit from a move to a 2.6 kernel
> and enabling preempt.
> 
> Cheers,
> Con
> 
> 

