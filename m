Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288639AbSAIKea>; Wed, 9 Jan 2002 05:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288662AbSAIKeU>; Wed, 9 Jan 2002 05:34:20 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:16192 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288639AbSAIKeJ>; Wed, 9 Jan 2002 05:34:09 -0500
Date: Wed, 9 Jan 2002 11:33:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020109113315.D1543@inspiron.school.suse.de>
In-Reply-To: <20020108030431.0099F38C58@perninha.conectiva.com.br> <Pine.LNX.4.21.0201081153160.19178-100000@freak.distro.conectiva> <3C3B5305.267EFC14@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C3B5305.267EFC14@zip.com.au>; from akpm@zip.com.au on Tue, Jan 08, 2002 at 12:13:57PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 12:13:57PM -0800, Andrew Morton wrote:
> Marcelo Tosatti wrote:
> > 
> > > Andrew Morten`s read-latency.patch is a clear winner for me, too.
> > 
> > AFAIK Andrew's code simply adds schedule points around the kernel, right?
> > 
> > If so, nope, I do not plan to integrate it.
> 
> I haven't sent it to you yet :)  It improves the kernel.  That's
> good, isn't it?  (There are already forty or fifty open-coded
> rescheduling points in the kernel.  That patch just adds the
> missing (and most important) ten).  

yes, only make sure not to add live locks.

> reviewable place - submit_bh().  However that won't prevent

agreed, I also merged this part of mini-ll in 18pre2aa1 infact.

Andrea
