Return-Path: <linux-kernel-owner+w=401wt.eu-S965314AbWLPBUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965314AbWLPBUO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 20:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965319AbWLPBUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 20:20:13 -0500
Received: from sbcs.cs.sunysb.edu ([130.245.1.15]:37261 "EHLO
	sbcs.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965314AbWLPBUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 20:20:09 -0500
Date: Fri, 15 Dec 2006 20:20:02 -0500 (EST)
From: Nikolai Joukov <kolya@cs.sunysb.edu>
X-X-Sender: kolya@compserv1
To: Bryan Henderson <hbryan@us.ibm.com>
cc: Ed Tomlinson <edt@aei.ca>, linux-fsdevel@vger.kernel.org,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
In-Reply-To: <OFCB8FCFF5.BA0A74ED-ON88257246.0000FE7C-88257246.0001E5FD@us.ibm.com>
Message-ID: <Pine.GSO.4.53.0612152004080.10315@compserv1>
References: <OFCB8FCFF5.BA0A74ED-ON88257246.0000FE7C-88257246.0001E5FD@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >The idea behind the cloneset is that most of the blocks (or files)
> >do not change in either source or target.  This being the case its only
> necessary
> >to update the changed elements.  This means updates are incremental. Once
> >the system has figured out what it needs to update its usable and if you
> access
> >an element that should be updated you will see the correctly updated
> version - even
> >though backgound resyncing is still in progress.
>
> I still can't tell what you're describing.  With RAID1 as well, only
> changed elements ever get updated.  I have two identical filesystems,
> members of a RAIF set.  I change one file.  One file in each member
> filesystem gets updated, and I again have two identical filesystems.
>
> How would a cloneset work differently, and how would it be better?

Thanks, Bryan.  I was about to write almost the same.

> > This type of logic is great for backups.
>
> Can you give an example of using it for backup?

I guess, you can mount Versionfs (yet another stackable file system)
below RAIF and above one of the lower file systems or use some other
versioning file system such as ext3cow.  This will allow rolling back to
any older file system version at any time.

Nikolai.
---------------------
Nikolai Joukov, Ph.D.
Filesystems and Storage Laboratory
Stony Brook University
