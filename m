Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136136AbRD0RhL>; Fri, 27 Apr 2001 13:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136138AbRD0RhC>; Fri, 27 Apr 2001 13:37:02 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:53682 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S136136AbRD0Rgq>;
	Fri, 27 Apr 2001 13:36:46 -0400
Message-ID: <3AE9AE2B.9262A66D@mandrakesoft.com>
Date: Fri, 27 Apr 2001 13:36:43 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Neil Conway <nconway.list@ukaea.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.LNX.4.21.0104270953280.2067-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Fri, 27 Apr 2001, Neil Conway wrote:
> >
> > I'm surprised that dump is deprecated (by you at least ;-)).  What to
> > use instead for backups on machines that can't umount disks regularly?
> 
> Note that dump simply won't work reliably at all even in 2.4.x: the buffer
> cache and the page cache (where all the actual data is) are not
> coherent. This is only going to get even worse in 2.5.x, when the
> directories are moved into the page cache as well.

> Dump was a stupid program in the first place. Leave it behind.

Dump/restore are useful, on-line dump is silly.  I am personally amazed
that on-line, mounted dump was -ever- supported.  I guess it would work
if mounted ro...

dump is still the canonical solution, IMHO, for saving and restoring
filesystem metadata OFFLINE.  tar/cpio can be taught to do stuff like
security ACLs and EAs and such, but such code and formats are not yet
standardized, and they do not approach dump when it comes to taking an
accurate snapshot of the filesystem.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
