Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130579AbRAQWYo>; Wed, 17 Jan 2001 17:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130605AbRAQWYe>; Wed, 17 Jan 2001 17:24:34 -0500
Received: from fungus.teststation.com ([212.32.186.211]:19889 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S130579AbRAQWYQ>; Wed, 17 Jan 2001 17:24:16 -0500
Date: Wed, 17 Jan 2001 23:24:05 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: "Scott A. Sibert" <kernel@hollins.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: oops in 2.4.1-pre8
In-Reply-To: <3A66130E.8010004@hollins.edu>
Message-ID: <Pine.LNX.4.30.0101172312550.18642-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Scott A. Sibert wrote:

> I'm consistently getting an oops when accessing any smbfs mount whether
> running 'ls' inside the smbfs mount or hitting TAB for filename
> completion of a directory in an smbfs mount.  I have another machine
> (dual P2/300 w/320MB memory) that does not have this problem.  The P2

That other machine is not compiled with bigmem, I assume.


> Ethernet is compiled into the kernel as is smbfs (not as modules).  I've
> compiled this kernel with 4GB bigmem support (otherwise I only get 8xxMB
> total).

The smbfs cache code in 2.4.0 doesn't work with bigmem. For now disable
bigmem or don't use smbfs, it's oopsing all the time.

Rainer Mager reported the same thing yesterday ("Oops with 4GB memory
setting in 2.4.0 stable" if you want to read the thread).

I am currently looking into this ... what kind of server are you
connecting to? win2k/NT4/9x? It is easier to test with those than the more
exotic OS/2 & NetApp.

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
