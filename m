Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132029AbRAHWLc>; Mon, 8 Jan 2001 17:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132260AbRAHWLW>; Mon, 8 Jan 2001 17:11:22 -0500
Received: from dnvrdslgw14poolB96.dnvr.uswest.net ([63.228.85.96]:32587 "EHLO
	q.dyndns.org") by vger.kernel.org with ESMTP id <S132029AbRAHWLK>;
	Mon, 8 Jan 2001 17:11:10 -0500
Date: Mon, 8 Jan 2001 15:11:08 -0700 (MST)
From: Benson Chow <blc@q.dyndns.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: `rmdir .` doesn't work in 2.4
In-Reply-To: <20010108225451.A968@stefan.sime.com>
Message-ID: <Pine.LNX.4.31.0101081501560.10554-100000@q.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not very portable at all...

hpux = HP/UX 10.2

hpux:~$ mkdir foo
hpux:~$ cd foo
hpux:~/foo$ rmdir "`pwd`"
rmdir: /home/blc/foo: Cannot remove mountable directory
hpux:~/foo$ rmdir .
rmdir: cannot remove .. or .
hpux:~/foo$ rmdir /home/blc/foo
rmdir: /home/blc/foo: Cannot remove mountable directory
hpux:~/foo$ rmdir ./
rmdir: ./: Cannot remove mountable directory
hpux:~/foo$

Maybe HP/UX is messed up as well.

But anyway I'll try to step out of the building that i'm trying to blow
up, regardless of whether or not it will work on a particular OS will
hold onto a floor of it till it's done with it...

-bc

On Mon, 8 Jan 2001, Stefan Traby wrote:

> Date: Mon, 8 Jan 2001 22:54:51 +0100
> From: Stefan Traby <stefan@hello-penguin.com>
> To: Alexander Viro <viro@math.psu.edu>
> Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
> Subject: Re: `rmdir .` doesn't work in 2.4
>
> On Mon, Jan 08, 2001 at 12:58:20PM -0500, Alexander Viro wrote:
>
> > Shell equivalent is rmdir `pwd`. Also portable.
>
> Very portable - not.
>
> rmdir "`pwd`" !!!
>
> --
>
>   ciao -
>     Stefan
>
> "     ( cd /lib ; ln -s libBrokenLocale-2.2.so libNiedersachsen.so )     "
>
> Stefan Traby                Linux/ia32               fax:  +43-3133-6107-9
> Mitterlasznitzstr. 13       Linux/alpha            phone:  +43-3133-6107-2
> 8302 Nestelbach             Linux/sparc       http://www.hello-penguin.com
> Austria                                    mailto://st.traby@opengroup.org
> Europe                                   mailto://stefan@hello-penguin.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
