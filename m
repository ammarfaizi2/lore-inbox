Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbUB0Amh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbUB0Amh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:42:37 -0500
Received: from agminet04.oracle.com ([141.146.126.231]:54915 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S261515AbUB0Amf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:42:35 -0500
Date: Thu, 26 Feb 2004 16:42:19 -0800
From: Wim Coekaerts <wim.coekaerts@oracle.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Jochen Roemling <jochen@roemling.net>, linux-kernel@vger.kernel.org
Subject: Re: shmget with SHM_HUGETLB flag: Operation not permitted
Message-ID: <20040227004219.GC13976@ca-server1.us.oracle.com>
References: <1tCuq-3AH-1@gated-at.bofh.it> <1tCEo-3Lh-27@gated-at.bofh.it> <1tDgT-4r2-13@gated-at.bofh.it> <403E87CF.1080409@roemling.net> <20040226160616.E1652@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226160616.E1652@build.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Feb 26, 2004 at 04:06:16PM -0800, Chris Wright wrote:
> * Jochen Roemling (jochen@roemling.net) wrote:
> > Chris Wright wrote:
<snip> 
> >                  if (!capable(CAP_IPC_LOCK)) {
> >                          err = -EPERM;
> >                          goto out;
> >                  }
> > 
> > There is nothing around that says: "Allow this only without HUGETLB".
> > Are you sure that this capability is my problem?
> 
> Yes, take a look at fs/hugetlbfs/inode.c::hugetlb_zero_setup()

Rik had a patch in rhel3 for nonroot mlock() which made this all work,
I will post a patch for 2.6. from what I understand it's very useful for
the gpg folks to have, eg wide audience for this patch. just need to do
a bit more testing and having Rik review it then ll send it out (or
maybe he feels like getting shot and he will ;)

Wim

