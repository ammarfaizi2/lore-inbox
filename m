Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTLXFuy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 00:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTLXFuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 00:50:54 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:2809 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263357AbTLXFuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 00:50:50 -0500
Subject: Re: DEVFS is very good compared to UDEV
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: rml@ximian.com, stan@ccs.neu.edu, Jari.Soderholm@edu.stadia.fi
Content-Type: text/plain
Organization: 
Message-Id: <1072236794.1743.244.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Dec 2003 22:33:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Love writes:
> On Tue, 2003-12-23 at 16:20, Jari Soderholm wrote:

>> I am quite advanced Linux user who has used DEVFS quite
>> long time, and have also been a little suprised that it
>> has been marked OBSOLETE in 2.6 kernel.
>
> devfs is marked obsolete for more reasons that
> just the presence of udev.  Devfs is also buggy,
> poorly designed, and unmaintained.

That may be, but at least the idea wasn't defective.

>> DEVFS is a really simple to use, compile it into
>> kernel and configure the programs to use DEVFS
>> filenames and thats it.
>
> udev, in time, we be even easier than this: just
> install it.  It will use the historic kernel naming
> (FHS names) so you need not change your programs,
> although a devfs-style naming policy is possible

How quickly we forget where those names came from!
Richard Gooch originally used the traditional names.
Linus ordered the names changed as a condition for
acceptance into the kernel. Of course, that led to
devfsd being a requirement, which kind of took away
the whole point of using devfs.

The Linus-approved names made devfs a pain to use,
so few people used devfs and fewer helped out.

Richard is only to blame for his inability to spell
/dev/disk correctly. For that, he belongs in "jail"
with a "j". It was enough of an eyesore to make me
give up on devfs.

>> I think that it is very good that devicename
>> files are out from the disk, one cannot delete
>> those files, disk errors do not affect the,
>> and searching device files is faster.
>
> udev can store files on a tmpfs (or any other)
> mount, if so desired.

That can be done. It is neither clean nor fast.
It's a nasty hack to emulate a proper devfs.

>> Booting kernel is faster compared to UDEV.
>
> Today, udev is not even involved in booting,
> so this cannot possible be true.  If you mean
> running the udev initscript is slow, perhaps
> it is: but eventually that will not be needed.
>
> Also, udev is nascent and still under development.
> It has not been fine-tuned yet.

Certainly. It amuses me to no end watching sysfs
mutate into /proc++ and udev growing day by day.
Do you remember all the trash-talking about how
sysfs was going to be a strict and clean view of
the power management dependencies instead of a
bloated mess that slurps in random functionality
like /proc does?

Let's just get it over with: per-process XML
in /sys, built-in SQL engine, CJK i18n, an ASN.1
view of it all, and /sys/bin/GnomeMailReader.

>> And DEVFS has worked for years for me at least
>> very well, I haven't had any problems with it.
>
> Lucky you.  It is a mess.

I can well imagine not trusting it for a serious
multi-user shell box. It works for others.

>> If one you look at the /sysfs-directory there are
>> device filenames, (but not the actual devicefiles), so
>> it does same thing that DEVFS, but actually much worce
>> way, it created devicefilenames in the ram, but
>> one cannot use them, because they are not devicefiles.
>
> sysfs is a tree of the kernel's in-memory
> representation of devices.
>
> We do _not_ want to put the device naming
> policy in the kernel.  User-space should handle that.

Uh huh. They're named in /sys though, and on the
kernel command line for root and console.

We might as well admit to the truth here.

>> Why could you develop it so that UDEV could create
>> those actual device files there also, then most linux
>> users would not need those horrible scipts anymore.
>> All that is then needed link from /sysfs to /dev dir.
>
> This was proposed before, and certainly do-able.

Excellent. So we could have a real devfs, based on
kernel code that is supposedly more solid.

>> In my option good operating system kernel should
>> use disk and external programs little as possible.
>
> In my opinion, good operating system kernels should
> be wise to correctly delineate between what should
> be in user-space and what should be in the kernel.

There is no "correct". There are desktop systems,
stripped-down embedded boxes, full-featured embedded
boxes, business servers, compute cluster nodes...
An optional devfs is a very good choice to have.


