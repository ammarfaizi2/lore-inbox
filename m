Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290695AbSAYOyG>; Fri, 25 Jan 2002 09:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290697AbSAYOx5>; Fri, 25 Jan 2002 09:53:57 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:2035 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S290695AbSAYOxn>; Fri, 25 Jan 2002 09:53:43 -0500
Date: Fri, 25 Jan 2002 09:57:37 -0500
To: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre4aa1
Message-ID: <20020125095737.A1129@earthlink.net>
In-Reply-To: <20020124222357.C901@earthlink.net> <Pine.LNX.4.33L.0201250132450.32617-100000@imladris.surriel.com> <20020125132653.A28068@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020125132653.A28068@suse.de>; from davej@suse.de on Fri, Jan 25, 2002 at 01:26:53PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  it may be useful if Randy can throw a real world test
>  into the benchmarking, to get a better comparison of
>  the various systems. The obvious one that springs to mind
>  would be something like compilation of a large source tree

Thanks for the feedback.

2.5.2-dj5 wins the lucky "first-timer" award on the new tests.

Extract/configure/make/check autoconf-2.52:
Executes over 100000 processes and creates a lot of small
temporary files.  Won't hit the disk much on this box.

Extract/Configure/make/test perl-5.6.1:
For perl, "make test" is executed 5 times.  "make test" is about 
75% system and 25% user, which may provide more variation between 
kernel versions.

>  Or maybe timing an updatedb. Its realworld enough in that its
>  a daily task, generates lots of IO..

I'll time updatedb too.  updatedb may vary over time, depending
on how many src trees are extracted.  I'll make an effort to
keep that variable consistent.

-- 
Randy Hron

