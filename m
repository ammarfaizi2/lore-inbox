Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287330AbRL3D4B>; Sat, 29 Dec 2001 22:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287328AbRL3Dzv>; Sat, 29 Dec 2001 22:55:51 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:6664 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287327AbRL3Dzp>;
	Sat, 29 Dec 2001 22:55:45 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Janitor Project 
	<kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: [ANNOUNCE] include dependency graph script 
In-Reply-To: Your message of "Sun, 30 Dec 2001 01:30:33 -0200."
             <20011230013033.A2856@conectiva.com.br> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 30 Dec 2001 14:55:30 +1100
Message-ID: <23616.1009684530@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2001 01:30:33 -0200, 
Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:
>	For the people that like me, Daniel Phillips and Manfred Spraul are
>working on pruning the include dependencies in the kernel sources I made a
>simple script to make a graphviz file to plot the dependencies in a nice
>graphic, its availabe at:
>
>http://www.kernel.org/pub/linux/kernel/people/acme/hviz

I suggest that you prune linux/config.h and autoconf.h from all graphs.
The dependency system does not depend directly on those files, instead
it depends on individual config options.

It makes more sense to list the individual config options that an
include file depends on, see the code in scripts/mkdep.c.  Even then it
would be better to suppress the config options by default and only list
them when requested.

