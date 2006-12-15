Return-Path: <linux-kernel-owner+w=401wt.eu-S1030404AbWLOX6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbWLOX6Z (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 18:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWLOX6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 18:58:25 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:62658 "EHLO aeimail.aei.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030404AbWLOX6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 18:58:24 -0500
From: Ed Tomlinson <edt@aei.ca>
To: Nikolai Joukov <kolya@cs.sunysb.edu>
Subject: Re: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
Date: Fri, 15 Dec 2006 18:58:19 -0500
User-Agent: KMail/1.9.5
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
References: <Pine.GSO.4.53.0612122217360.22195@compserv1> <200612150747.02708.edt@aei.ca> <Pine.GSO.4.53.0612151504360.3466@compserv1>
In-Reply-To: <Pine.GSO.4.53.0612151504360.3466@compserv1>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612151858.19935.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 December 2006 15:11, Nikolai Joukov wrote:
> > On Wednesday 13 December 2006 12:47, Nikolai Joukov wrote:
> > > We have designed a new stackable file system that we called RAIF:
> > > Redundant Array of Independent Filesystems
> >
> > Do you have a function similar to an an EMC cloneset?   Basicily a cloneset
> > tracks what has changed in both the source and target luns (drives).  When one
> > updates the cloneset the target is made identical to the source.  Its a great
> > way to do backups.  Its an important feature to be able to write to the target drives.
> > I would love to see this working at a filesystem level.
> 
> Well, if you mount RAIF over your file system and a for-backups file
> system, RAIF can replicate the files on both of them automatically.  I
> guess that's what you need.

Yes and no.  The idea behind the cloneset is that most of the blocks (or files)
do not change in either source or target.  This being the case its only necessary
to update the changed elements.  This means updates are incremental.  Once
the system has figured out what it needs to update its usable and if you access
an element that should be updated you will see the correctly updated version - even 
though backgound resyncing is still in progress.  This type of logic is great for backups.

Thanks
Ed Tomlinson
