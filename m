Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268298AbUIBMzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268298AbUIBMzA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 08:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268301AbUIBMzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 08:55:00 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:15006 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S268298AbUIBMy1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 08:54:27 -0400
Message-ID: <41371702.8030704@andrew.cmu.edu>
Date: Thu, 02 Sep 2004 08:50:10 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org> <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>...
>But _my_ point is, no user program is going to take _advantage_ of
>anything that only one filesystem on one system offers.
>
>So there's no point.
>
>It's much saner (from _any_ app standpoint) to roll their own database in 
>user space - that way it just works.
>
>In other words, nobody is really ever going to take advantage of this. 
>This is _not_ how technical advanncement happens. The way you get people 
>to take advantage of something is to have a nice gradual ramp-up, not a 
>sudden new feature that they can't realistically use.
>...
>

Sure, but there are plenty of existing interfaces that you could 
emulate.  One could make a small library to use a transactional 
filesystem to implement the Berkely DB interface (libdb) for example.  
So on filesystems without such support your app could use the regular 
userspace database, but on a transactional filesystem it'd just use 
regular files, which would simplify database management and likely 
increase performance over the userspace-only version (libdb is pretty 
slow).  In terms of functionality it'd just be a drop-in replacement, 
just like math libraries that use MMX/SSE when available.

    - Jim Bruce

