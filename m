Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317591AbSFRUF5>; Tue, 18 Jun 2002 16:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSFRUF4>; Tue, 18 Jun 2002 16:05:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30982 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317591AbSFRUFa>; Tue, 18 Jun 2002 16:05:30 -0400
Date: Tue, 18 Jun 2002 13:05:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken 
In-Reply-To: <E17KPDr-0003Pa-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0206181302300.872-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Jun 2002, Rusty Russell wrote:
>
> NO.  They want to be node-affine.  They don't want to specify what
> CPUs they attach to.

So you're going to have separate interfaces for that? Gag me with a volvo,
but that's idiotic.

Besides, even that would be broken. You want bitmaps, because bitmaps is
really what it is all about. It's NOT about "I must run on this CPU", it
can equally well be "I mustn't run on those two CPU's that are hosting the
RT part of this thing" or something like that.

		Linus

