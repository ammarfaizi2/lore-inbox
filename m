Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286234AbRLJLv0>; Mon, 10 Dec 2001 06:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286235AbRLJLvQ>; Mon, 10 Dec 2001 06:51:16 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:60682 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S286234AbRLJLu7>;
	Mon, 10 Dec 2001 06:50:59 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200112101150.fBABosS271828@saturn.cs.uml.edu>
Subject: Re: File copy system call proposal
To: pavel@suse.cz (Pavel Machek)
Date: Mon, 10 Dec 2001 06:50:54 -0500 (EST)
Cc: quinn@nmt.edu (Quinn Harris), linux-kernel@vger.kernel.org
In-Reply-To: <20011209153522.A138@toy.ucw.cz> from "Pavel Machek" at Dec 09, 2001 03:35:23 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I would like to propose implementing a file copy system call.
>> I expect the initial reaction to such a proposal would be "feature
>> bloat" but I believe some substantial benefits can be seen possibly
>> making it worthwhile, primarily the following:
>>
>> Copy on write:
>
> You want cowlink() syscall, not copy() syscall. If they are on different
> partitions, let userspace do the job.

That looks like a knee-jerk reaction to stuff going in the kernel.
I want maximum survival of non-UNIX metadata and maximum performance
for this common operation. Let's say you are telecommuting, and...

You have mounted an SMB share from a Windows XP server.
You need to copy a file that has NTFS security data.
The file is 99 GB in size, on the far side of a 33.6 kb/s modem link.
Now copy this file!
Better yet, maybe you have two mount points or mounted two shares.

????

Filesystem-specific user tools are abominations BTW. We don't
have reiser-mv, reiser-cp, reiser-gmc, reiser-rm, etc.
