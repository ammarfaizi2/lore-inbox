Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWGORi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWGORi4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 13:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWGORi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 13:38:56 -0400
Received: from [83.101.158.20] ([83.101.158.20]:39688 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750728AbWGORiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 13:38:55 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH -mm 5/7] add user namespace
Date: Sat, 15 Jul 2006 20:39:50 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200607152039.50786.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Sat, 2006-07-15 at 06:35 -0600, Eric W. Biederman wrote:
> > I hope the confusion has passed for Trond.  My impression was he
> > figured this was per process data so it didn't make sense any where
> > near a filesystem, and the superblock was the last place it should
> > be.
>
> You are still using the wrong abstraction. Data that is not global to
> the entire machine has absolutely _no_ place being put into the
> superblock. It doesn't matter if it is process-specific,
> container-specific or whatever-else-specific, it will still be vetoed.
>
> If your real problem is uid/gid mapping on top of generic filesystems,
> then have you looked into the *BSD solution of using a stackable
> filesystem (i.e. umapfs)?

A stackable FS is really overkill here, when all that is needed is a simple 
mapping.  An easy solution would be, to allow for perMount Handlers via 
hooks into the VFS, as was suggested in the '[RFC] VFS: FS CoW using 
redirection' thread.

Thanks!

--
Al

