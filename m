Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbSKJDYI>; Sat, 9 Nov 2002 22:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbSKJDYI>; Sat, 9 Nov 2002 22:24:08 -0500
Received: from almesberger.net ([63.105.73.239]:32267 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S263276AbSKJDYH>; Sat, 9 Nov 2002 22:24:07 -0500
Date: Sun, 10 Nov 2002 00:30:27 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021110003027.C31205@almesberger.net>
References: <Pine.LNX.4.44.0211070731200.5567-100000@home.transmeta.com> <m1u1iqcpjg.fsf@frodo.biederman.org> <20021109223142.A31205@almesberger.net> <m17kfmce6c.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17kfmce6c.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sat, Nov 09, 2002 at 08:10:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> What I was thinking is that the process would for and exec
> something like "/etc/rc 6" or maybe "/etc/rc 7" to be clean.
> And that script would do all of the user space shutdown.

Yes, but init also does a kill(-1,...) to get rid of all processes,
before the last steps of system shutdown. So you have to somehow
make your "page holding" process survive beyond this point.

> My feel is that kexec-on-panic is a rather different problem.

You make it a different problem by assuming that you'd have a
kernel that is specifically built for running at a "safe"
location. If you assume that you're just using your normal
kernel, the two problems converge again. There are still a
few things that are different, like the checksumming, but
they can safely be added at a later time.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
