Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136744AbREAWt6>; Tue, 1 May 2001 18:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136748AbREAWts>; Tue, 1 May 2001 18:49:48 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:41484
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S136744AbREAWtd>; Tue, 1 May 2001 18:49:33 -0400
Date: Tue, 01 May 2001 18:48:51 -0400
From: Chris Mason <mason@suse.com>
To: Daniel Elstner <daniel.elstner@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs+lndir problem [was: 2.4.4 SMP: spurious EOVERFLOW
 "Value too large for defined data type"]
Message-ID: <71770000.988757331@tiny>
In-Reply-To: <20010502004152.23a0751b.daniel@master.daniel.homenet>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, May 02, 2001 12:41:52 AM +0200 Daniel Elstner
<daniel.elstner@gmx.net> wrote:

> Hi,
> 
> On Mon, 30 Apr 2001 21:03:47 -0400 Chris Mason <mason@suse.com> wrote:
> 
>> > Apparently it's a reiserfs/symlink problem.
>> > I tried doing the lndir on an ext2 partition, sources still
>> > on reiserfs. And it worked just fine!
>> 
>> Neat, thanks for the extra details.  Does that mean you can consistently
>> repeat on reiserfs now?  What happens when you do the lndir on reiserfs
>> and diff the directories?
> 
> I just played around a bit with the following results:
> 
> sources on reiserfs, lndir on reiserfs -> make fails, diff ok
> sources on reiserfs, lndir on ext2     -> make ok
> sources on ext2, lndir on reiserfs     -> make fails, diff ok
> 
> Doing the diff against a second copy of the tree shows no errors, too.
> Always the same behaviour: You have to run lndir at least twice to
> get the error. If the link tree was already set up after a boot, the
> error occurs only after rm + lndir + rm + lndir.
> 
> There's a strange way to get things working just like after a reboot.
> After diff'ing the link tree with the 2nd copy (both on reiserfs),
> make World won't fail - at least once.

Ok, can you reproduce with a set of sources other than X?  I would leave
glibc alone for now, unless you can reproduce on ext2.

-chris





