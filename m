Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131550AbQLHPo1>; Fri, 8 Dec 2000 10:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131652AbQLHPoR>; Fri, 8 Dec 2000 10:44:17 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:39409 "EHLO
	tantra.cygnus.co.uk") by vger.kernel.org with ESMTP
	id <S131550AbQLHPoN>; Fri, 8 Dec 2000 10:44:13 -0500
From: David Howells <dhowells@redhat.com>
To: Christoph Rohland <cr@sap.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,preliminary] cleanup shm handling 
In-Reply-To: Your message of "08 Dec 2000 14:23:06 +0100."
             <qwwu28fkpxh.fsf@sap.com> 
Date: Fri, 08 Dec 2000 15:13:45 +0000
Message-ID: <20295.976288425@warthog.cygnus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> here is my first shot for cleaning up the shm handling. It did survive
> some basic testing but is not ready for inclusion. 

Can you help me with an SHM related problem?

I'm currently writing a Win32 emulation kernel module to help speed Wine up,
and I'm writing the file mapping support stuff at the moment
(CreateFileMapping and MapViewOfFile).

I have PE Image mapping just about working (fixups, misaligned file sections
and all), but I'm trying to think of a good way of doing anonymous shared
mappings without having to hack the main kernel around too much (so far I've
only had to add to kernel/ksyms.c).

Is there a reasonable way I could hook into the SHM system to "reserve" a
chunk of shared memory of a particular size, and then a second hook by which I
can "map" _part_ of that into a process's address space?

Cheers,
David

PS: to anyone else reading this, if you wrote do_generic_file_read(), it
rocks!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
