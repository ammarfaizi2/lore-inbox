Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287858AbSAIQtQ>; Wed, 9 Jan 2002 11:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287855AbSAIQtG>; Wed, 9 Jan 2002 11:49:06 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:22800 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S287850AbSAIQsu>; Wed, 9 Jan 2002 11:48:50 -0500
Date: Wed, 9 Jan 2002 10:48:47 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200201091648.KAA19440@tomcat.admin.navo.hpc.mil>
To: aia21@cam.ac.uk, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: Difficulties in interoperating with Windows
In-Reply-To: <5.1.0.14.2.20020109152921.026ad0a0@pop.cus.cam.ac.uk>
Cc: lkml@andyjeffries.co.uk, linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...
> Er, you have to have the same algorithms or at least you need to achieve 
> the same input and output which often requires the exact same algorithm 
> otherwise you cannot achieve the same input/output...
>

Yup - and then you hit the "trade secrets" problem.

> To give a concrete example from ntfs, when collating attribute names (and 
> file names for the matter) in order to determine where to place them in an 
> inode, if you do not apply all collation criteria found in the windows 
> driver, you will inevitably do the collation wrong at least in some corner 
> cases and you have a broken filesystem on your hands when you are writing.

I believe the collating sequence/filenames is documentd. What isn't documented
is how the journal file is handled. How recovery is handled.

I think trying to make that compatable hits the trade secrets. Compatability
is needed if you expect to take a partition from one OS to another and still
have the possible crash conditions handled. NTFS write was (briefly) available
until the lawyers came to the door. Along with an external tool to recover
NTFS file systems.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
