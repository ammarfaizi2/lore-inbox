Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272415AbRH3TM3>; Thu, 30 Aug 2001 15:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272416AbRH3TMJ>; Thu, 30 Aug 2001 15:12:09 -0400
Received: from mons.uio.no ([129.240.130.14]:12436 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S272415AbRH3TMA>;
	Thu, 30 Aug 2001 15:12:00 -0400
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-ac1/2/3 allows multiple mounts of NFS filesystem on same mountpoint
In-Reply-To: <000901c13179$be7b9ae0$6caaa8c0@kevin>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 30 Aug 2001 21:12:11 +0200
In-Reply-To: "Kevin P. Fleming"'s message of "Thu, 30 Aug 2001 10:32:29 -0700"
Message-ID: <shsd75d2whg.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Kevin P Fleming <kevin@labsysgrp.com> writes:

     > Accidentally <G> I mounted a filesystem from my server onto my
     > workstation twice. Mount gave me no error....

That's right. The 2.4 VFS removed the global restriction on the number
of mounts on a single mountpoint. So?

If people expect this to be an error, then the correct thing is for
the VFS restriction to be reinstated. I see no reason why it should be
the responsibility of the filesystem to check for this sort of
thing. A mountpoint is after all the one place where the VFS is
actually *designed* to override the filesystem.

Cheers,
  Trond
