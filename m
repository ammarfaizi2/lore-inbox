Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbTDGRvR (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 13:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263569AbTDGRvR (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 13:51:17 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:64010 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP id S263564AbTDGRvQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 13:51:16 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] new syscall: flink
Date: 7 Apr 2003 17:37:36 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <b6sd10$45g$1@abraham.cs.berkeley.edu>
References: <20030407165009.13596.qmail@email.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1049737056 4272 128.32.153.211 (7 Apr 2003 17:37:36 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 7 Apr 2003 17:37:36 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clayton Weaver wrote:
>Once a process unlinks the last directory entry referencing a particular
>inode that it has an
>open fd for and then passes the open fd to some other process
>(regardless of exactly how it does that), it seems to me that it has
>conceded any interest in the previous security constraints associated
>with that inode or with the recently
>unlinked last directory entry for it.

Huh?  That's not the Unix model.  If I pass you a read-only file
descriptor, you're not supposed to be able to get write access to
the fd.  If you can, that's a security hole.  This is true whether
the fd refers to an inode still linked into the filesystem or not.

>The cases with potential security implications are all in the context of
>flink()ing to an open fd for an inode that still corresponds to at least
>one directory entry.

No, that's not correct.
