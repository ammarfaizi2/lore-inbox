Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbRAIKfB>; Tue, 9 Jan 2001 05:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131522AbRAIKev>; Tue, 9 Jan 2001 05:34:51 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:13711 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S129763AbRAIKei>; Tue, 9 Jan 2001 05:34:38 -0500
To: <elixer@erols.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: FS callback routines
In-Reply-To: <000c01c079db$78ab39e0$59aa0141@cc230545b>
Reply-To: Daniel Stodden <stodden@in.tum.de>
From: Daniel Stodden <stodden@informatik.tu-muenchen.de>
In-Reply-To: "Sean R. Bright"'s message of "Tue, 9 Jan 2001 02:33:27 +0000"
Message-ID: <87zoh1rp3v.fsf@bitch.localnet>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 9 Jan 2001 11:34:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sean R. Bright" <elixer@erols.com> writes:

> 	Ok, before I begin, don't shoot me down, but I had an idea for a kernel
> modification and was wondering how feasible the group thought it was.
> 
> 	I was writing a user space application to monitor a folder's contents.  The
> folder itself contained 100 folders, and each of those contained 24 folders.
> While writing the code to traverse the directory structure I realized that
> instead of my software figuring out when things change, why not just have
> the fs tell my application when something was updated.  For example, say we
> had a function called watch_fs(), that took an inode reference and a
> function pointer and maybe a bitmask of events to watch for.  When that
> inode (or its children) were changed, why couldn't the fs code call the
> callback function I specified?
> 
> 	I have no idea how expensive this would be or if its even worth it at this
> point.  It also wouldn't be portable at all considering that I know of no
> other OS that does this (could be wrong).
> 
> 	Like I said, I am not asking that this be (necessarily) implemented, I am
> just curious as to what the percieved performance ramifications would be if
> it were to implemented, say, by a virgin kernel developer ;)

you want to have a look at

http://oss.sgi.com/projects/fam/

resp. imon, the corresponding kernel modules. 

this has been around for quite some time now. enlightenment has
been/still is? using it since it's earliest incarnations of its file
manager extension efm. (same with kde? not sure..)

i'm wondering whether this could get into the mainstream kernels soon?
i'm not really deep in the filesystem layers, but this sounds to me
like an extremely useful feature.

could anyone comment on section 2 of
http://oss.sgi.com/projects/fam/imon.txt ? would this actually be the
way to do it or is there any better method?


regards,
dns

-- 
___________________________________________________________________________
 mailto:stodden@in.tum.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
