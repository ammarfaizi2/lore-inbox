Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131074AbRCGN7N>; Wed, 7 Mar 2001 08:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131076AbRCGN7E>; Wed, 7 Mar 2001 08:59:04 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:12384 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S131074AbRCGN6r>; Wed, 7 Mar 2001 08:58:47 -0500
Date: Wed, 7 Mar 2001 07:57:40 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103071357.HAA12261@tomcat.admin.navo.hpc.mil>
To: marcelo@conectiva.com.br, Alexander Viro <viro@math.psu.edu>
Subject: Re: Mapping a piece of one process' addrspace to another?
Cc: Jeremy Elson <jelson@circlemud.org>, linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br>:
> On Wed, 7 Mar 2001, Alexander Viro wrote:
> 
> > 
> > 
> > You are reinventing the wheel.
> > man ptrace (see PTRACE_{PEEK,POKE}{TEXT,DATA} and PTRACE_{ATTACH,CONT,DETACH})
> 
> With ptrace data will be copied twice. As far as I understood, Jeremy
> wants to avoid that. 

The the only way left would be to mmap a file. The second process could
mmap the same file to put data.I believe the buffers holding the data
would be shared between the two processes.

How the first process detects that I don't know (semaphore? signal?).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
