Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263193AbSKJC5c>; Sat, 9 Nov 2002 21:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSKJC5c>; Sat, 9 Nov 2002 21:57:32 -0500
Received: from almesberger.net ([63.105.73.239]:27147 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S263193AbSKJC5c>; Sat, 9 Nov 2002 21:57:32 -0500
Date: Sun, 10 Nov 2002 00:03:46 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021110000346.B31205@almesberger.net>
References: <Pine.LNX.4.44.0211091510060.1571-100000@home.transmeta.com> <m1of8ycihs.fsf@frodo.biederman.org> <1036894347.22173.6.camel@irongate.swansea.linux.org.uk> <m1k7jmcgo5.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k7jmcgo5.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sat, Nov 09, 2002 at 07:16:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> So my gut impression at least says an interface that ignores where
> the image wants to live just adds complexity in other places,

Linus' alloc_kernel_pages function would actually be able to handle
this, provided that the "validity callback" checks if the allocated
page happens to be in one of the destination areas.

I'm not so sure if this implementation is really that much more
compact than your current conflict resolution, though. Also, it may
be hairy in scenarios where you actually expect to fill more than
50% of system memory. (But your concerns about a 128MB limit scare
me, too. I realize that people have taken initrds to extremes I
never quite imagined, but that still looks a little excessive :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
