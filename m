Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268414AbTBNNn6>; Fri, 14 Feb 2003 08:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268417AbTBNNn6>; Fri, 14 Feb 2003 08:43:58 -0500
Received: from almesberger.net ([63.105.73.239]:19213 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S268414AbTBNNnz>; Fri, 14 Feb 2003 08:43:55 -0500
Date: Fri, 14 Feb 2003 10:53:38 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kuznet@ms2.inr.ac.ru,
       davem@redhat.com, kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
Message-ID: <20030214105338.E2092@almesberger.net>
References: <20030214120628.208112C464@lists.samba.org> <Pine.LNX.4.44.0302141410540.1336-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302141410540.1336-100000@serv>; from zippel@linux-m68k.org on Fri, Feb 14, 2003 at 02:21:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> On Fri, 14 Feb 2003, Rusty Russell wrote:
>> This isn't even a sensible question: "This is not a module problem.
>> How does module locking help?"

I have to side with Rusty here - it's really not a module problem.

The module changes only make this a little worse, because they
follow the philosophy that this can't be fixed, so try_module_get
and friends try to implement the right kind of locking for unload
races (but for little else) without tripping over those "unfixable"
bugs.

The good news is that you can start fixing all those bugs right
now, and even without Rusty's consent :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
