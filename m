Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317665AbSGUOQb>; Sun, 21 Jul 2002 10:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317670AbSGUOQb>; Sun, 21 Jul 2002 10:16:31 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:60170 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317665AbSGUOQa>; Sun, 21 Jul 2002 10:16:30 -0400
Date: Sun, 21 Jul 2002 11:19:27 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: memory leak?
In-Reply-To: <yw1xn0sluqom.fsf@gladiusit.e.kth.se>
Message-ID: <Pine.LNX.4.44L.0207211118241.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Jul 2002, Måns Rullgård wrote:

> I noticed that doing lots or file accesses causes the used memory to
> increase, *after* subtracting buffers/cache. Here is an example:

> Here 24 MB of memory have been used up. Repeating the du seems to have
> little effect. This directory has ~3200 subdirs and 13400 files.

> Is this a memory leak? I get the same results with ext2, ext3,
> reiserfs and nfs.

See /proc/slabinfo for the numbers, the memory is most likely
being used in the dentry_cache, the inode_cache and in buffer
heads.

This memory will be reclaimed when the system needs it.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

