Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262218AbSI0PP7>; Fri, 27 Sep 2002 11:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbSI0PP6>; Fri, 27 Sep 2002 11:15:58 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:45098 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262218AbSI0PP5>;
	Fri, 27 Sep 2002 11:15:57 -0400
Date: Fri, 27 Sep 2002 18:20:33 +0300
From: Dan Aloni <da-x@gmx.net>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: using memset in a module
Message-ID: <20020927152033.GA4710@callisto.yi.org>
References: <Pine.LNX.4.33L2.0209261550410.32681-100000@dragon.pdx.osdl.net> <1033081345.3371.35.camel@zaphod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033081345.3371.35.camel@zaphod>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 07:02:26PM -0400, Shaya Potter wrote:
> On Thu, 2002-09-26 at 18:51, Randy.Dunlap wrote:
> > On 26 Sep 2002, Shaya Potter wrote:
> > 
> > | I have a problem using memset in a module.
> > |
[snio]
> > What gcc options are you using?
> > You need -O2 at least.
> >           ^ upper-case letter O
> 
> 
> yes, using it.
> 
> gcc -Wall -DMODULE -DMODVERSIONS -D__KERNEL__ -DLINUX -DEXPORT_SYMTAB
> -I/usr/src/linux/include/ -I`pwd`/../migration
> -I`pwd`/..//virtualization -O2 -fomit-frame-pointer -pipe
> -fno-strength-reduce -malign-loops=2 -malign-jumps=2 -malign-functions=2
> -o fs1.o -c virtualizers/fs1.c

Try adding -nostdinc. Prehaps memset is picked up as 'extern' somehow.
If that doesn't work, compile with -E instead of -c and grep the
preprocessing output for memset, that may give a clue.

-- 
Dan Aloni
da-x@gmx.net
