Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286130AbRLTFkB>; Thu, 20 Dec 2001 00:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286128AbRLTFjm>; Thu, 20 Dec 2001 00:39:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:30851 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286127AbRLTFjc>;
	Thu, 20 Dec 2001 00:39:32 -0500
Date: Wed, 19 Dec 2001 21:39:10 -0800 (PST)
Message-Id: <20011219.213910.15269313.davem@redhat.com>
To: bcrl@redhat.com
Cc: billh@tierra.ucsd.edu, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011219224717.A3682@redhat.com>
In-Reply-To: <20011219190716.A26007@burn.ucsd.edu>
	<20011219.191354.65000844.davem@redhat.com>
	<20011219224717.A3682@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Wed, 19 Dec 2001 22:47:17 -0500

   Well maybe yourself and others should make some comments about it then.
   
Because, like I keep saying, it is totally uninteresting for most of
us.

   Who cares about Java?

The people telling me on this list how important AIO is for Linux :-)

   What about high performance LDAP servers or tux-like 
   userspace performance?

People have done "faster than TUX" userspace web service with the
current kernel, that is without AIO.  There is no reason you can't
do a fast LDAP server with the current kernel either, any such claim
is simply rubbish.  Why do we need AIO again?

   How about faster select and poll?

You don't need faster select and poll as demonstrated by the
userspace "faster than TUX" example above.

   An X server that doesn't have to make a syscall to find out that
   more data has arrived?

Who really needs this kind of performance improvement?  Like anyone
really cares if their window gets the keyboard focus or a pixel over a
AF_UNIX socket a few nanoseconds faster.  How many people do you think
believe they have unacceptable X performance right now and that
select()/poll() syscalls overhead is the cause?  Please get real.

People who want graphics performance are not pushing their data
through X over a filedescriptor, they are either using direct
rendering in the app itself (ala OpenGL) or they are using shared
memory for the bulk of the data (ala Xshm or Xv extensions).

   What about nbd or iscsi servers that are in userspace and have all
   the benefits  that their kernel side counterparts do?

I do not buy this claim that it is not possible the achieve the
desired performance using existing facilities.

The only example of AIO benefitting performance I see right now are
databases.

Franks a lot,
David S. Miller
davem@redhat.com
