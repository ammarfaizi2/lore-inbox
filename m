Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268565AbTBOACs>; Fri, 14 Feb 2003 19:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268566AbTBOACs>; Fri, 14 Feb 2003 19:02:48 -0500
Received: from almesberger.net ([63.105.73.239]:8975 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S268565AbTBOACo>; Fri, 14 Feb 2003 19:02:44 -0500
Date: Fri, 14 Feb 2003 21:12:26 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kuznet@ms2.inr.ac.ru,
       davem@redhat.com, kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
Message-ID: <20030214211226.I2092@almesberger.net>
References: <20030214120628.208112C464@lists.samba.org> <Pine.LNX.4.44.0302141410540.1336-100000@serv> <20030214105338.E2092@almesberger.net> <Pine.LNX.4.44.0302141500540.1336-100000@serv> <20030214153039.G2092@almesberger.net> <Pine.LNX.4.44.0302142106140.1336-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302142106140.1336-100000@serv>; from zippel@linux-m68k.org on Fri, Feb 14, 2003 at 09:09:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Step one is still to understand the problem. I described a very real 
> problem, once this problem is solved (which can be done in different 
> ways),

I though we were talking about

	static data_used_by_callbacks;
	...
	register_foo(&stuff_with_callbacks);
	...
	unregister_foo(&stuff_with_callbacks);
	make_unusable(&data_used_by_callbacks)
	...
	/* oops, we just got a callback */

("data_used_by_callbacks" could be a pointer to kmalloc'ed
memory, etc.)

This kind of problem seems to be understood well enough.
But maybe you mean something else ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
