Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129847AbRAPDVX>; Mon, 15 Jan 2001 22:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbRAPDVN>; Mon, 15 Jan 2001 22:21:13 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:31758 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129847AbRAPDVC>; Mon, 15 Jan 2001 22:21:02 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: pre5 VM feedback..
Date: 15 Jan 2001 19:20:51 -0800
Organization: Transmeta Corporation
Message-ID: <940emj$6re$1@penguin.transmeta.com>
In-Reply-To: <3A63A9AE.345CBAF3@mandrakesoft.com> <940cq0$6fe$1@penguin.transmeta.com> <3A63B9E8.F7E850F@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A63B9E8.F7E850F@mandrakesoft.com>,
Jeff Garzik  <jgarzik@mandrakesoft.com> wrote:
>Linus Torvalds wrote:
>> In article <3A63A9AE.345CBAF3@mandrakesoft.com>,
>> Jeff Garzik  <jgarzik@mandrakesoft.com> wrote:
>> >$!@#@! pre6 is already out :)
>
>> Yes, and for heavens sake don't use it, [...]
>
>Too late...  First and foremost, a correction:  The VM data I posted was
>for pre1, not pre5.  Here is the VM data from a freshly rebooted pre6,
>if that's worth anything:  http://gtf.org/garzik/vm2/
>
>Hopefully pre6 will survive long enough to complete tulip testing :)

Careful, careful, careful.

The problem is that pre6 survives quite nicely, but because of the silly
typo in __mark_inode_dirty() it won't actually mark inodes dirty. 
Unless you are actually using the newly integrated raiser-fs, in which
case you should be just peachy ;)

Note that the bug is not even noticeable under many loads - especially
if you have lots of memory.  The inodes just get happily cached for a
long time.  Which is why I could release a pre6, not even noticing that
it's strange and not writing out inode data to the disk. 

With a gig of RAM, inodes tend to cache really well. 

Now, I'm not saying your filesystem is toast.  I'm just saying that if
you booted up in pre6, I'd suggest a quick reboot into a better kernel
might be a good idea (be a jock, and do a sync and just push the reset
button to force a proper fsck when it comes up - just in case).

(And yes, I renamed the pre6's really quickly, so you had to be unlucky
to see them.)

			Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
