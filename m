Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbVI2DYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbVI2DYu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 23:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVI2DYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 23:24:50 -0400
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:65094 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S1750808AbVI2DYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 23:24:49 -0400
Message-ID: <433B5E2B.4030805@thinrope.net>
Date: Thu, 29 Sep 2005 12:23:23 +0900
From: Kalin KOZHUHAROV <kalin@thinrope.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Documentation: getting and installing git
References: <200509290305.01625.jesper.juhl@gmail.com>	 <20050929020221.GN30883@pasky.or.cz> <9a874849050928193437a176bc@mail.gmail.com>
In-Reply-To: <9a874849050928193437a176bc@mail.gmail.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just my 2 yen below:
Jesper Juhl wrote:
> On 9/29/05, Petr Baudis <pasky@ucw.cz> wrote:
> 
>>  Hello,
>>
>>  I think Pavel Machek had some short git HOWTO as well, so I'm Cc'ing him.
>>
> 
> Ok, thanks. I was not aware of that.
> 
> 
> 
>>  In general, I think it's not a good idea to just duplicate GIT
>>documentation in the kernel tree. If you think the GIT documentation is
>>insufficient or is missing some "quick start" document, it'd be more
>>reasonable to submit patches for GIT, but I'd keep kernel's GIT
>>documentation to kernel-specific usage and tips'n'tricks.
>>
> 
> The reason for this document is to cater to the people who have a
> kernel source tree available, know the kernel is managed with git, but
> don't know how to obtain it. Such people (myself included) probably
> take a quick look in linux-<version>/Documentation/ for a document
> telling them how to get and install git. This document is written to
> serve those people.
> 
> 
> 
>>Dear diary, on Thu, Sep 29, 2005 at 03:05:01AM CEST, I got a letter
>>where Jesper Juhl <jesper.juhl@gmail.com> told me that...
>>
>>>--- /dev/null 2005-09-28 20:05:57.000000000 +0200
>>>+++ linux-2.6.14-rc2-git3/Documentation/get-and-install-git.txt       2005-09-29 02:57:59.000000000 +0200
>>>@@ -0,0 +1,130 @@
>>>+     Getting and installing `git` and pulling your first tree
>>>+     --------------------------------------------------------
>>>+
>>>+             (Writen by Jesper Juhl, September 2005)
>>>+
>>>+
>>>+This document describes how to obtain and install the `git` tool used (among
>>>+other things) to manage the Linux kernel source tree. It also shows you how
>>>+to use git to pull down your first copy of the vanilla Linux kernel source
>>>+(current git head version).
>>
>>  Since you're cc'ing me, you'll get a shameless plug. ;-) What about
> 
> 
> I'm Cc'ing you exactely because I thought you would have some valuable input :)
> 
> 
> 
>>some decent short notice like:
>>
>>        Note that you might prefer to use one of the simpler user interfaces
>>        available for GIT, e.g. the Cogito layer or StGIT patch manager. See
>>        the GIT homepage for details.
>>
> 
> something like that would probably make sense, yes.
> 
> 
> 
>>>+Those who already have an older version of git can grab a newer version with
>>>+     it clone http://www.kernel.org/pub/scm/git/git.git LOCALDIR
>>
>>  Missing leading 'g'.
>>
> 
> Whoops.
> 
> 
> 
>>>+To obtain the latest git source snapshot go to this URL:
>>>+     http://www.codemonkey.org.uk/projects/git-snapshots/git/
>>>+and download the latest version (at the time of this writing the exact filename
>>>+is git-2005-09-29.tar.gz, but a symlink called git-latest.tar.gz is also
>>>+provided that will always pull the latest git source regardless of its actual
>>>+filename).
>>
>>  I think recommending the latest development snapshot instead of the
>>latest release is a really bad idea if you don't have some really
>>compelling reason to do so. The snapshot can be variously broken and
>>buggy, while a release gives you some stable reference point and path
>>from it you can follow.
>>
> 
> Hmm, yes, you are probably right. I should recommend the latest
> release and just provide a small note on how to get the latest
> snapshot. Thanks.
> 
> 
> 
>>...
>>
>>>+At this point you should have git installed and available in your PATH.
>>
>>  Perhaps you might rather want to extend GIT's INSTALL file?
>>
> 
> I can provide a patch for that if you like, sure.
> 
> 
> 
>>>+Now it's time to download your first kernel source tree. To do that you should
>>>+first change into the directory where you want to store the kernel source in a
>>>+subdir. I'll assume you want to keep kernel source in ~/linux-kernel, so do
>>>+this :
>>>+
>>>+     $ mkdir ~/linux-kernel ; cd ~/linux-kernel
>>>+
>>>+Now let's use git to download the latest git HEAD (the current head of Linus'
>>>+development tree). Execute these commands to do this :
>>>+
>>>+     $ git clone \
>>>+       rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
>>>+       linux-2.6
>>>+     $ cd linux-2.6
>>>+     $ rsync -a --verbose --stats --progress \
>>>+       rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
>>>+       .git/
>>
>>Why the second rsync command? If you are after tags and other heads, you
>>can run it just on .git/refs/.
>>
> 
> Hmm, right, my bad.

I am not at all versed ing git, but AFAS rsync is considered, wouldn't it be times faster to start 
from a tarball (say latest -rc) and then rsync. Most people have it on their machines or it is 
cached all around the net. Even if they don't have it, getting a tarball to prime the rsync will be 
a good idea IMHO.

>>But actually, it is very dangerous. Never ever run it later than right
>>after the initial clone (ignore what the "Kernel Hackers' Guide to git"
> 
> 
> This is supposed to tell people how to get and install git for *the
> very first time*, so this would be the initial clone.
> 
> 
> 
>>tells you!). If you did any local commits, it will likely trash them,
>>and if you didn't, it will probably completely confuse the tools which
>>care about updating your working tree with new changes.
>>
> 
> I think the best thing is just to drop that second bit.
> 
> 
> 
>>>+When the download finishes you'll have a brand sparkling new git HEAD linux
>>>+kernel source tree in ~/linux-kernel/linux-2.6
>>
>>[Nitpick] I'm not a native English speaker, but I think "brand new
>>sparkling" is more right.
>>
> 
> I'm not a native english speaker either, so you may very well be right
> - I honestly don't know :)
> 
> 
> 
>>>+If you want to do a git bisection search to find what patch caused a problem,
>>>+please see the Documentation/git-bisect.txt document in the git source tree.
>>>+You may also want to read and/or use Documentation/git-bisect-script.txt
>>
>>This notice would be quite useful in the rather antique
>>Documentation/BUG-HUNTING file.
>>
> 
> Not a bad suggestion - anyone else have an oppinion on that?
> 
> 
> Thank you for your constructive feedback. Much appreciated.

Kalin.
-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

