Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262820AbSJLEIV>; Sat, 12 Oct 2002 00:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262826AbSJLEIV>; Sat, 12 Oct 2002 00:08:21 -0400
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:48649 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S262820AbSJLEIT>; Sat, 12 Oct 2002 00:08:19 -0400
Message-Id: <200210120414.g9C4E1X10038@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
To: Rob Landley <landley@trommello.org>, Hans Reiser <reiser@namesys.com>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Date: Fri, 11 Oct 2002 23:14:01 -0500
X-Mailer: KMail [version 1.3.2]
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <3DA7647C.3060603@namesys.com> <20021012012807.1BB5B635@merlin.webofficenow.com>
In-Reply-To: <20021012012807.1BB5B635@merlin.webofficenow.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 October 2002 03:26 pm, Rob Landley wrote:
> On Friday 11 October 2002 07:53 pm, Hans Reiser wrote:
<snip>
> A little side project I'm working on now (in my copious free time) is mount
> point relocation support.  (You can mount the same filesystem a second time
> in another location (mount --bind makes this easy), and they share a
> superblock so open files should be happy, but you still can't detach the
> first mount point.  Not with a hacksaw, or explosives...)  It's more an
> excuse to learn the new VFS layer than anything else, but it's
> functionality I would in fact have a use for, strange enough...

Not quite sure that I'm following the _why_ of this one, but maybe I'm just 
slow.

> I'm also looking for an "unmount --force" option that works on something
> other than NFS.  Close all active filehandles (the programs using it can
> just deal with EBADF or whatever), flush the buffers to disk, and unmount. 
> None of this "oh I can't do that, you have a zombie process with an open
> file...", I want  "guillotine this filesystem pronto, capice?" behavior.

Now _this_ I *like*.  I've wanted this for _a long time_.  Not that I have 
that much spare time, but I'd like to help if I can!

> Of course loopback mounts would be kind of upset about this, but to be
> honest: tough.  The loopback block device gives them an I/O error, and the
> filesystem should just cope.  Floppies do this all the time with dust and
> cat hair and stuff...

Yup.  This is required sometimes.  Ever have a CD mounted that the (#$)# 
kernel won't let you umount even though lsof and /proc insist that's there's 
nothing open, but all you can do is an fscking reboot?!!!

Thanks

-Nick
