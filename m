Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268480AbTBOAmb>; Fri, 14 Feb 2003 19:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268481AbTBOAmb>; Fri, 14 Feb 2003 19:42:31 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:16910 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S268480AbTBOAma>; Fri, 14 Feb 2003 19:42:30 -0500
Date: Sat, 15 Feb 2003 01:51:52 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Werner Almesberger <wa@almesberger.net>
cc: Rusty Russell <rusty@rustcorp.com.au>, <kuznet@ms2.inr.ac.ru>,
       <davem@redhat.com>, <kronos@kronoz.cjb.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Migrating net/sched to new module interface
In-Reply-To: <20030214211226.I2092@almesberger.net>
Message-ID: <Pine.LNX.4.44.0302150148010.1336-100000@serv>
References: <20030214120628.208112C464@lists.samba.org>
 <Pine.LNX.4.44.0302141410540.1336-100000@serv> <20030214105338.E2092@almesberger.net>
 <Pine.LNX.4.44.0302141500540.1336-100000@serv> <20030214153039.G2092@almesberger.net>
 <Pine.LNX.4.44.0302142106140.1336-100000@serv> <20030214211226.I2092@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 14 Feb 2003, Werner Almesberger wrote:

> I though we were talking about
> 
> 	static data_used_by_callbacks;
> 	...
> 	register_foo(&stuff_with_callbacks);
> 	...
> 	unregister_foo(&stuff_with_callbacks);
> 	make_unusable(&data_used_by_callbacks)
> 	...
> 	/* oops, we just got a callback */
> 
> ("data_used_by_callbacks" could be a pointer to kmalloc'ed
> memory, etc.)
> 
> This kind of problem seems to be understood well enough.

Yes, and now compare how the solutions differ when the data is static and 
when it's allocated.

bye, Roman

