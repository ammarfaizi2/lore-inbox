Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129639AbRBPUkb>; Fri, 16 Feb 2001 15:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130889AbRBPUkU>; Fri, 16 Feb 2001 15:40:20 -0500
Received: from entropy.muc.muohio.edu ([134.53.213.10]:48513 "EHLO
	entropy.muc.muohio.edu") by vger.kernel.org with ESMTP
	id <S129639AbRBPUkM>; Fri, 16 Feb 2001 15:40:12 -0500
Date: Fri, 16 Feb 2001 15:39:57 -0500 (EST)
From: George <greerga@entropy.muc.muohio.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: out of memory?
In-Reply-To: <E14Tht7-0002jj-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0102161538030.3286-100000@entropy.muc.muohio.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2001, Alan Cox wrote:

>> VM: do_try_to_free_pages failed for myprog.pl
>> VM: do_try_to_free_pages failed for myprog.pl
>> VM: do_try_to_free_pages failed for kupdate (just saw this once)
>>
>> The kernel is compiled with the rh-7.0 kgcc (egcs-2.91.66), and I've
>> patched it to get raid 0.90 and reiserfs 3.5.29.
>> What's going on? How bad is this?
>
>The VM logs cases where it actually ends up having trouble getting free
>memory and sits around before it eventually gets life going again. Its mostly
>a debugging aid and in itself harmless.

I've had 2.2.18 go into an infinite kernel loop with that message when
running out of memory.  ALT+SysRq would respond and print what it tries to
do, but never actually accomplish it. (i.e., it'd say "Syncing disks." but
never actually do it.) Apparently userspace never ran again because sockets
would be accepted still but never progress.

-George Greer

