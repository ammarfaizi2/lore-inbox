Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264282AbTKLSqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 13:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbTKLSqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 13:46:17 -0500
Received: from ACaen-202-1-7-4.w81-248.abo.wanadoo.fr ([81.248.160.4]:7234
	"HELO Genesyme.localdomain") by vger.kernel.org with SMTP
	id S264282AbTKLSqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 13:46:15 -0500
Subject: Re: reiserfs 3.6 problem with test9
From: Philippe <rouquier.p@wanadoo.fr>
To: Samium Gromoff <deepfire@ibe.miee.ru>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <87smkt63xu.wl@drakkar.ibe.miee.ru>
References: <87smkt63xu.wl@drakkar.ibe.miee.ru>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1068663075.17051.12.camel@Genesyme>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 12 Nov 2003 19:51:16 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 12/11/2003 à 15:45, Samium Gromoff a écrit :
> > > Last time I had a box with similar problems it was memory.  I'd put
> > > your system through a memtest.
> >
> > thanks for your answer.
> > I did as you said but no problem (memtest 3.0).
> 
> For how long did you run the test?
> 
> It is known that often a 24-hour memtest is not enough to find real world
> memory failures.
> 
> Also it is known that gcc (yeah you`ll wonder) is much better at finding them,
> so there`s the question: do you compile stuff often, and if so, whether
> gcc bails out with "internal error" messages sometimes?
> 
> Also, if i were you i would do the following:
> 
> bash-2.05b$ dd if=/dev/urandom of=test bs=1048576 count=1024
> bash-2.05b$ bzip2 test
> bash-2.05b$ bunzip2 test.bz2
> 
> And if you have a memory failure bzip2 checksumming would show that up on the
> bunzip2 stage.
> 
> regards, Samium Gromoff

thanks for your answer.
I ran memtest for a whole night yesterday (again) : nothing.
I have never had any problem with gcc. execpt that sometimes after a big
compiling I have some files damaged but _they_are_not_the_ones_used_
by_gcc_. they always are in another directory.
I ran the test with dd and bzip2 : no problem.

Yet I'm afraid it is too late. I switched to ext3 today as my all system
was gradually becoming unusable after compiling large apps. I was fed up
with rebuilding partitions.

Now, it runs fine. but it might not mean anything about my hardware ...
I 'll try this.

Anyway I'm willing to explore the problem; in particular because some
other people seem to have the same problem.
Moreover reiserfs is faster. I liked it and I'd like to come back to it.

Note: I kept the original reiserfs partition with the errors. So if
someone needs any log to figure out where the problem comes from I have
everything at hand. I'm also willing to perform other tests. 

regards.
Philippe Rouquier.

