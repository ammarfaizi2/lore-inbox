Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265515AbSKFB6v>; Tue, 5 Nov 2002 20:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265516AbSKFB6v>; Tue, 5 Nov 2002 20:58:51 -0500
Received: from almesberger.net ([63.105.73.239]:54281 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265515AbSKFB6u>; Tue, 5 Nov 2002 20:58:50 -0500
Date: Tue, 5 Nov 2002 23:05:05 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andy Pfiffer <andyp@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021105230505.D10679@almesberger.net>
References: <20021105221050.A10679@almesberger.net> <Pine.GSO.4.21.0211052017320.6521-100000@steklov.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0211052017320.6521-100000@steklov.math.psu.edu>; from viro@math.psu.edu on Tue, Nov 05, 2002 at 08:37:10PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> That's not obvious.  By the same logics, we would need syscalls for
> turning off overcommit, etc., etc.

Okay okay, add file system specific ioctls and sysctl to my list
of alternative mechanisms :-)

> FWIW, I suspect that
> 	open("/proc/image", O_EXCL|O_WRONLY);
> 	bunch of lseek()/write()
> 	close()

Hmm, interesting. Yes, that should work. One would of course have
to retain the current interface for in-kernel use (e.g. MCORE), but
that's probably okay. Let's see what Eric thinks about it - it's
his code after all.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
