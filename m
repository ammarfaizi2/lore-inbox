Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbQJ0HFD>; Fri, 27 Oct 2000 03:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129119AbQJ0HEy>; Fri, 27 Oct 2000 03:04:54 -0400
Received: from [212.32.186.211] ([212.32.186.211]:29173 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129111AbQJ0HEp>; Fri, 27 Oct 2000 03:04:45 -0400
Date: Fri, 27 Oct 2000 09:04:41 +0200 (CEST)
From: Urban Widmark <urban@svenskatest.se>
To: David Won <phlegm@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel newby help.... What's causing my Oops
In-Reply-To: <00102702261003.01068@phlegmish.com>
Message-ID: <Pine.LNX.4.21.0010270843130.8150-100000@cola.svenskatest.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2000, David Won wrote:

> Oct 22 22:37:20 phlegmish kernel: Process esd (pid: 2356, stackpage=c1715000)
[snip]
> Oct 22 22:37:20 phlegmish kernel: Call Trace: 
> [smbfs:__insmod_smbfs_O/lib/modules/2.4.0-test8/kernel/fs/smbfs/sm+-220073/96] 
> [smbfs:__insmod_smbfs_O/lib/modules/2.4.0-test8/kernel/fs/smbfs/sm+-237584/96] 
> [smbfs:__insmod_smbfs_O/lib/modules/2.4.0-test8/kernel/fs/smbfs/sm+-245443/96] 
> [__fput+35/144] [_fput+17/64] [fput+18/24] [filp_close+82/92] 

It certainly has smbfs printed all over it. But I don't know how to decode
the call trace ... "sm+-220073" ?


Could you describe what it is you are doing when this happens?
Are you perhaps playing sound from a mounted smbfs? (esd)
Could you test if this is or isn't related to smbfs?
(ie don't mount any smbfs stuff and do the same things you normally do)

For reproducing oopses it is nice to use a separate system, either a
second installation on the same machine (with none of the normal
partitions mounted) or a second machine.

You could also try 2.4.0-test10-pre6 which is the latest (but if it is
smbfs related it should not make any difference).

The second oops I don't know anything about except that it may have been
triggered by the first oops.

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
