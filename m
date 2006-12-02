Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424978AbWLCFgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424978AbWLCFgN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 00:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424977AbWLCFgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 00:36:13 -0500
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:24234
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S1424974AbWLCFgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 00:36:12 -0500
Date: Sat, 2 Dec 2006 04:58:51 -0800
From: Brad Boyer <flar@allandria.com>
To: Jeff Layton <jlayton@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] ensure i_ino uniqueness in filesystems without permanent inode numbers (via idr)
Message-ID: <20061202125851.GA30187@cynthia.pants.nu>
References: <457040C4.1000002@redhat.com> <20061201085227.2463b185.randy.dunlap@oracle.com> <20061201172136.GA11669@dantu.rdu.redhat.com> <20061202053013.GC26389@cynthia.pants.nu> <45723CDB.1060304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45723CDB.1060304@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 09:56:27PM -0500, Jeff Layton wrote:
> My main reasoning for doing this was that the structures involved are 
> per-superblock. There is virtually no reason that a filesystem would 
> ever need to touch these structures in another filesystem.

I don't think this is relevant to the issue. I wouldn't expect that
if you allow people to use this functionality that they would go
poking around in other filesystems. I would expect people to use it
on the filesystem they are writing.

> So, this is essentially a service to make it easy for filesystems to 
> implement i_ino uniqueness. I'm not terribly interested in making things 
> easier for proprietary filesystems, so I don't see a real reason to make 
> this available to them. They can always implement their own scheme to do 
> this.

This sounds slightly petty to me. For example, generic_file_read() is
there just to make it easier to implement the read callback, but it
isn't required. In fact, I would think that any filesystem complex
enough to be worth making proprietary would not use it. However, that
doesn't seem to me to be a good argument for marking it GPL-only. The
functionality in question is easier to reimplement, but that doesn't
make it right to force it on people just because of a license choice.

> I'm certainly open to discussion though. Is there a compelling reason to 
> open this up to proprietary software authors?

I don't think there is a compelling reason to open it up since the
functionality could be reimplemented if needed, but I also think
the only reason it is being marked GPL-only is the very common
attitude that there should not be any proprietary modules.

To be honest, I think it looks bad for someone associated with redhat
to be suggesting that life should be made more difficult for those
who write proprietary software on Linux. The support from commercial
software is a major reason for the success of the RHEL product line.
I can't imagine that this attitude will affect support from software
companies as long as there is a demand for software on Linux, but
it isn't exactly supportive.

	Brad Boyer
	flar@allandria.com

