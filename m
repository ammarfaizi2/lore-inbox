Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132494AbRAPTQZ>; Tue, 16 Jan 2001 14:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132444AbRAPTQP>; Tue, 16 Jan 2001 14:16:15 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:12817 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S132357AbRAPTQC>; Tue, 16 Jan 2001 14:16:02 -0500
Date: Tue, 16 Jan 2001 14:18:43 -0500
From: Chris Mason <mason@suse.com>
To: Jakob Borg <jakob@borg.pp.se>, Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG with 2.4.1-pre7 reiserfs
Message-ID: <215700000.979672723@tiny>
In-Reply-To: <20010116195837.A707@borg.pp.se>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, January 16, 2001 07:58:37 PM +0100 Jakob Borg
<jakob@borg.pp.se> wrote:

> On Tue, Jan 16, 2001 at 10:36:43AM -0800, Linus Torvalds wrote:
>> > I seem to remember more possibly useful information scrolling by my
>> > screen, but it seems to not have made it to the logs, and I will shut
>> > down and fsck the filesystem now...
>> 
>> It really needs the stack-trace to debug this sanely (along with
>> translations of what the hex numbers are - see the bugreporting
>> documentation in the kernel source tree). 
> 
> Got that in the other mail subjected "More information ... ". In the
> meantime it seems the filesystem is unhurt because of this, but reiserfsck
> says
> 
> uread_super_block: bad block is found at a new superblock location
> uread_super_block: bad block is found at an old superblock location
> 
> which seems bogus. This is reiserfsck from the same suite that mkreiserfs
> came from ("reiserfsprogs 3.x") so they should be talking about the same
> sort of filesystem.
> 

The BUG you hit should not corrupt anything, that debugging code is
actually there to prevent silent corruption due to lack of locking.

It is likely you are using an fsck version that can't read the 3.6.x
format.  They are still packaging the beta fsck tool for the new format,
I'm not sure the exact download URL yet.

When you mount the FS it tells you which version it is, please include that
info as well.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
