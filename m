Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289610AbSAOTqE>; Tue, 15 Jan 2002 14:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289612AbSAOTp3>; Tue, 15 Jan 2002 14:45:29 -0500
Received: from cs.columbia.edu ([128.59.16.20]:13959 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S289615AbSAOTpN>;
	Tue, 15 Jan 2002 14:45:13 -0500
Date: Tue, 15 Jan 2002 14:45:05 -0500 (EST)
Message-Id: <200201151945.g0FJj5Ca026371@shekel.mcl.cs.columbia.edu>
From: Erez Zadok <ezk@cs.columbia.edu>
To: Birger Lammering <b.lammering@science-computing.de>
Cc: amd-dev@cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: nfs3 problem: aix-server, amd, linux 2.4.10 - 2.4.17pre8 client 
In-Reply-To: Your message of "Tue, 18 Dec 2001 16:10:39 +0100."
             <15391.23663.215547.622349@stderr.science-computing.de> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <15391.23663.215547.622349@stderr.science-computing.de>, Birger Lammering writes:
> 
[...]
> An idea for a possible (and ugly) work around, that came up here, was
> to tell amd to use the mount command rather than the mount system
> call. This can be done by editing the NIS map. I find this rather
> inconvenient for our purpose - to say the least :-/. Would it be
> possible to invent an amd.conf option (i.e. 'nfs_program=mount') that
> tells amd to use the mount/umount programs rather than the system
> calls? Or can I replace the mount system call in
> conf/mount/mount_linux.c by a system("mount ...") call and recompile?
> :-)

Both ideas, as you say, are ugly workarounds.  The problem is elsewhere (and
it's possible it already got fixed by a patch Ion committed to am-utils very
recently).

I don't like the idea of an amd.conf option to override what should really
be in the mount maps.  How would you tell it which entries to override?

If the problem is that /bin/mount does something that amd's own mount(2)
call doesn't, then Ion and I will fix the linux mounting code in am-utils.

> Cheers,
> Birger

Erez.
