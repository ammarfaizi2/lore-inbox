Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317676AbSGUOUC>; Sun, 21 Jul 2002 10:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317677AbSGUOUC>; Sun, 21 Jul 2002 10:20:02 -0400
Received: from mail.s3.kth.se ([130.237.48.5]:35336 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S317676AbSGUOUB>;
	Sun, 21 Jul 2002 10:20:01 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: memory leak?
References: <Pine.LNX.4.44L.0207211118241.12241-100000@imladris.surriel.com>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 21 Jul 2002 16:23:06 +0200
In-Reply-To: Rik van Riel's message of "Sun, 21 Jul 2002 11:19:27 -0300 (BRT)"
Message-ID: <yw1xwurptb1x.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> > I noticed that doing lots or file accesses causes the used memory to
> > increase, *after* subtracting buffers/cache. Here is an example:
> 
> > Here 24 MB of memory have been used up. Repeating the du seems to have
> > little effect. This directory has ~3200 subdirs and 13400 files.
> 
> > Is this a memory leak? I get the same results with ext2, ext3,
> > reiserfs and nfs.
> 
> See /proc/slabinfo for the numbers, the memory is most likely
> being used in the dentry_cache, the inode_cache and in buffer
> heads.
> 
> This memory will be reclaimed when the system needs it.

Does this mean that free and /proc/meminfo are incorrect?

-- 
Måns Rullgård
mru@users.sf.net
