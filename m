Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbTCEUJE>; Wed, 5 Mar 2003 15:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbTCEUJE>; Wed, 5 Mar 2003 15:09:04 -0500
Received: from twinlark.arctic.org ([208.44.199.239]:25223 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S261874AbTCEUJD>; Wed, 5 Mar 2003 15:09:03 -0500
Date: Wed, 5 Mar 2003 12:19:34 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Horrible L2 cache effects from kernel compile
In-Reply-To: <1046735907.7947.0.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.53.0303051216480.30080@twinlark.arctic.org>
References: <Pine.LNX.4.44.0303031108390.12011-100000@home.transmeta.com>
 <1046735907.7947.0.camel@irongate.swansea.linux.org.uk>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, Alan Cox wrote:

> On Mon, 2003-03-03 at 19:13, Linus Torvalds wrote:
> > dentry itself. Yes, you could make it smaller (you could remove the inline
> > string from it, for example, and you could avoid allocating it at
>
> How about at least making the inline string align to the slab alignment so we
> dont waste space ?

what what be best is the hash chaining pointers and the first N bytes of
the inline name in the same cacheline.  for 32B cache lines it looks like
it's at least two misses per chain now.  (er, well i'm looking at 2.4
source.)

-dean
