Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132825AbRC2T0o>; Thu, 29 Mar 2001 14:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132826AbRC2T0e>; Thu, 29 Mar 2001 14:26:34 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:3672 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S132825AbRC2T0X>; Thu, 29 Mar 2001 14:26:23 -0500
Date: Thu, 29 Mar 2001 13:25:41 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103291925.NAA69404@tomcat.admin.navo.hpc.mil>
To: xordoquy@aurora-linux.com, linux-kernel@vger.kernel.org
Subject: Re: Bug in the file attributes ?
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> 
> Hi,
> 
> I just made a manipulation that disturbs me. So I'm asking whether it's a
> bug or a features.
> 
> user> su
> root> echo "test" > test
> root> ls -l
> -rw-r--r--   1 root     root            5 Mar 29 19:14 test
> root> exit
> user> rm test
> rm: remove write-protected file `test'? y
> user> ls test
> ls: test: No such file or directory
> 
> This is in the user home directory.
> Since the file is read only for the user, it should not be able to remove
> it. Moreover, the user can't write to test.
> So I think this is a bug.

Nope - rm only updates the directory, which the user owns; not the file.
The prompt is just being nice.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
