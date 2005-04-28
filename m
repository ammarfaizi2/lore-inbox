Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVD1WkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVD1WkW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 18:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVD1WkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 18:40:20 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:50138 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262312AbVD1Wj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 18:39:26 -0400
In-Reply-To: <1114717567.11547.82.camel@lade.trondhjem.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: 7eggert@gmx.de, Andrew Morton <akpm@osdl.org>, bulb@ucw.cz,
       hch@infradead.org, jamie@shareable.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, linuxram@us.ibm.com,
       Miklos Szeredi <miklos@szeredi.hu>, Pavel Machek <pavel@ucw.cz>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Subject: Re: [PATCH] private mounts
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFAECB8B29.CBF40C89-ON88256FF1.00790823-88256FF1.007C85B5@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Thu, 28 Apr 2005 15:38:48 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M4_01112005 Beta 3|January
 11, 2005) at 04/28/2005 18:39:23,
	Serialize complete at 04/28/2005 18:39:23,
	Serialize by Router on D01ML604/01/M/IBM(Build V70_M4_01112005 Beta 3|January
 11, 2005) at 04/28/2005 18:39:24
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Root squashing is there to enforce the policy that nobody gets to access
>any files with uid=0,gid=0. IOW it is a policy that is first and
>foremost meant to make root-owned files untouchable.

That's the only thing it does well, but you'd have to convince me that 
that's what it was designed for and that's what everyone expects out of 
it.  The most salient effect of root squashing -- the one that takes 
people by surprise -- is that it removes the special rights an NFS server 
otherwise accords to uid 0.  If protecting files owned by uid=0, gid=0 
were the original design goal, the protocol could have been designed to do 
that while still giving uid 0 access to everybody else's files.

>>a process with CAP_DAC_OVERRIDE can get EACCES.  ... Whine, whine...
>Tough.

This is actually off-topic.  We're not talking about whether root 
squashing is a good compromise.  We started with the statement that the 
only existing thing like (some private mount proposal) is NFS root 
squashing and the statement that some people consider that broken.  That 
elicited a response from you that suggested you were unaware there was 
anything not to like about root squashing ("Really?") and then some 
descriptions of the objections.  The fact is that negative perceptions of 
root squashing exist.  I know you know that.  There are respectable 
technical people who don't agree with the compromise.  So if one is 
looking for a broadly acceptable design of private mounts, one might want 
to find one that doesn't use NFS root squashing as its precedent.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems

