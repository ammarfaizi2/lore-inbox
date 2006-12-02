Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936568AbWLBWG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936568AbWLBWG1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 17:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936567AbWLBWG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 17:06:27 -0500
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:64422
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S933754AbWLBWG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 17:06:26 -0500
Date: Fri, 1 Dec 2006 21:30:13 -0800
From: Brad Boyer <flar@allandria.com>
To: Jeff Layton <jlayton@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] ensure i_ino uniqueness in filesystems without permanent inode numbers (via idr)
Message-ID: <20061202053013.GC26389@cynthia.pants.nu>
References: <457040C4.1000002@redhat.com> <20061201085227.2463b185.randy.dunlap@oracle.com> <20061201172136.GA11669@dantu.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201172136.GA11669@dantu.rdu.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 12:21:36PM -0500, Jeff Layton wrote:
> Here's an updated (but untested) patch based on your suggestions. I also went
> ahead and made the exported symbols GPL-only since that seems like it would be
> appropriate here. Any further thoughts on it?

I don't know that this is a good idea. I know this isn't likely to be
a popular statement, but I think that there should be at least some
minor justification to making a symbol GPL-only (it won't take much).
This seems like exactly the sort of thing that should be a generic
service available to all filesystem implementors whether it's GPL or
not. The usual justification for GPL-only is that it's something
random modules shouldn't be touching anyway, but it's something that
some part of the tree which could be a module needs.

	Brad Boyer
	flar@allandria.com

