Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWBKCiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWBKCiW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 21:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWBKCiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 21:38:22 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:33694 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932090AbWBKCiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 21:38:22 -0500
Subject: Re: [Devel] Re: swsusp done by migration (was Re: [RFC][PATCH 1/5]
	Virtualization/containers: startup)
From: Sam Vilain <sam@vilain.net>
To: Vasily Averin <vvs@sw.ru>
Cc: devel@openvz.org, Kyle Moffett <mrmacman_g4@mac.com>,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       frankeh@watson.ibm.com, Andrey Savochkin <saw@sawoct.com>,
       Rik van Riel <riel@redhat.com>, greg@kroah.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Pavel Machek <pavel@ucw.cz>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       serue@us.ibm.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org
In-Reply-To: <43EC317C.9090101@sw.ru>
References: <43E38BD1.4070707@openvz.org>
	 <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org>	<43E3915A.2080000@sw.ru>
	 <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org>
	 <m1lkwoubiw.fsf@ebiederm.dsl.xmission.com> <43E71018.8010104@sw.ru>
	 <m1hd7condi.fsf@ebiederm.dsl.xmission.com>
	 <1139243874.6189.71.camel@localhost.localdomain>
	 <m13biwnxkc.fsf@ebiederm.dsl.xmission.com>	<20060208215412.GD2353@ucw.cz>
	 <m1mzh02y3m.fsf@ebiederm.dsl.xmission.com>
	 <7CCC1159-BF55-4961-BC24-A759F893D43F@mac.com>
	 <43EC170C.6090807@vilain.net>  <43EC317C.9090101@sw.ru>
Content-Type: text/plain
Date: Sat, 11 Feb 2006 15:38:18 +1300
Message-Id: <1139625499.12123.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-10 at 09:23 +0300, Vasily Averin wrote:
> >> <wishful thinking>
> >> I can see another extension to this functionality.  With appropriate 
> >> changes it might also be possible to have a container exist across 
> >> multiple computers using some cluster code for synchronization and 
> >> fencing.  The outermost container would be the system boot container, 
> >> and multiple inner containers would use some sort of network-
> >> container-aware cluster filesystem to spread multiple vservers across 
> >> multiple servers, distributing CPU and network load appropriately.
> >> </wishful thinking>
> > Yeah.  If you fudged/virtualised /dev/random, the system clock, etc you
> > could even have Tandem-style transparent High Availability.
> > </more wishful thinking>
> Could you please explain, why you want to virtualize /dev/random?

When checkpointing it is important to preserve all state.  If you are
doing transparent highly available computing, you need to make sure all
system calls get the same answers in the clones.  So you would need to
virtualise the entropy pool.

There are likely to be dozens of other quite hard problems in the way
first.  Like I said, wishful thinking :-).  

Sam.

