Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261875AbSKCNYy>; Sun, 3 Nov 2002 08:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261877AbSKCNYy>; Sun, 3 Nov 2002 08:24:54 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:21702 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261875AbSKCNYw>; Sun, 3 Nov 2002 08:24:52 -0500
Cc: "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
References: <Pine.LNX.4.44.0211021754180.2300-100000@home.transmeta.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Sun, 03 Nov 2002 14:30:58 +0100
Message-ID: <87of96vkz1.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Sun, 3 Nov 2002, Olaf Dietsche wrote:
>
>> Linus Torvalds <torvalds@transmeta.com> writes:
>> 
>> >  - Make a new file type, and put just that information in the directory
>> >    (so that it shows up in d_type on a readdir()).  Put the real data in
>> >    the file, ie make it largely look like an "extended symlink".
>> 
>> How would you go from a regular file to the new extended symlink?
>
> So I'd suggest _not_ attaching that capability to the sendmail binary
> itself, or to any inode number of that binary. A binary is a binary is a
> binary - it's just the data. Instead, I'd attach the information to the
> directory entry, either directly (ie the directory entry really has an
> extra field that lists the capabilities) or indirectly (ie the directory
> entry is really just an "extended symlink" that contains not just the path
> to the binary, but also the capabilities associated with it).

Now I understand. It's a combined symlink/capabilities pair. I thought
to have this extra direntry, containing capabilities only. But I
didn't get the connection between the binary and the cap direntry. You
go just the other way round from cap/symlink to the binary.

> The reason I like directory entries as opposed to inodes is that if you
> work this way, you can actually give different people _different_
> capabilities for the same program.  You don't need to have two different
> installs, you can have one install and two different links to it.

I thought that's what the inheritable vs. permitted set is for.

Regards, Olaf.
