Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267022AbTAFQOS>; Mon, 6 Jan 2003 11:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267025AbTAFQOR>; Mon, 6 Jan 2003 11:14:17 -0500
Received: from smtp.mailix.net ([216.148.213.132]:26795 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id <S267022AbTAFQOQ>;
	Mon, 6 Jan 2003 11:14:16 -0500
Date: Mon, 6 Jan 2003 17:22:51 +0100
From: Alex Riesen <fork0@users.sf.net>
To: Dirk Bull <dirkbull102@hotmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: shmat problem
Message-ID: <20030106162251.GA15900@steel>
Reply-To: Alex Riesen <fork0@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Doug, thanks for the reply. I've set SHM_RND in the call and used
> "__attribute__ ((aligned(4096)))" during the the declaration of variable 
> global01_
> (as shown below) such that it is aligned on a page boundary. I'm porting 
> code that was
> written for a Unix system to Linux and the example shown below is how the 
> code is implemented on Unix.

on which exactly?

> The example included executed correctly on:
> mandrake - ? (Can't remember, but it was an old version)
> 
> but fails to work on:
> redhat - 2.2.14-5.0
> debian - 2.2.9
> mandrake - 2.4.19-16mdk
> 
> We are currently working on mandrake - kernel 2.4.19-16mdk.

You have to add SHM_REMAP to shmat flags (see definitions of SHM_ flags).

> 
> 	if ( (shmptr = shmat(shmid, &global01_, SHM_RND)) == (void *) -1)
> 		printf("shmat error: %d %s\n",errno, strerror(errno));
> 	else

add SHM_REMAP.

-alex

