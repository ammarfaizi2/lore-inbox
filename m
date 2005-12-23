Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030592AbVLWSKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030592AbVLWSKp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 13:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030595AbVLWSKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 13:10:45 -0500
Received: from quechua.inka.de ([193.197.184.2]:9653 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1030592AbVLWSKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 13:10:44 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: nfs insecure_locks / Tru64 behaviour
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20051223013933.GB22949@mtholyoke.edu>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1EprNK-0005ZC-00@calista.inka.de>
Date: Fri, 23 Dec 2005 19:10:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20051223013933.GB22949@mtholyoke.edu> you wrote:
> That's exactly the problem.  The first obvious solution doesn't work.
> Your second solution does.  The directory must have the execute bit set
> for other, or the the file cannot be edited, no matter who owns the
> directory (unless the owner/group is nobody/nogroup).

Is it a edit problem or a directory-enter problem (i.e. can you do a "cd d"?).

Is it a general file access problem or only with vi (i.e. can do "echo bla >> file")

If it is a vi specific problem maybe the locking is the problem:

The insecure_locks on Linux server is  needed, cause Linux NFS Server will
serve lock requests normally only from root users, and True64 requests from
unpriveledged daemon user. This means fctnl locking cannot be done, and this
might be a problem for vi.

Otherwise check that lockd/statd is running on your server.

I dont know how to turn of locking in Tru64 vi (vim: set lock off) or Tru64
mount (linux: nolock).

Gruss
Bernd
