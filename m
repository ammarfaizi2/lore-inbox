Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264682AbSJ3OsQ>; Wed, 30 Oct 2002 09:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbSJ3OsQ>; Wed, 30 Oct 2002 09:48:16 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:46516 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S264682AbSJ3OsP> convert rfc822-to-8bit; Wed, 30 Oct 2002 09:48:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Larry McVoy <lm@bitmover.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ANNOUNCEMENT: Squashfs released (a highly compressed filesystem)
Date: Wed, 30 Oct 2002 08:53:09 -0600
User-Agent: KMail/1.4.1
Cc: Phillip Lougher <phillip@lougher.demon.co.uk>,
       Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org
References: <3DBF43ED.70001@lougher.demon.co.uk> <3DBF5A08.9090407@pobox.com> <20021029201110.A29661@work.bitmover.com>
In-Reply-To: <20021029201110.A29661@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210300853.09342.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 October 2002 10:11 pm, Larry McVoy wrote:
> > A r/w compressed filesystem would be darned useful too :)
>
> mmap(2) is, err, hard.  Not impossible, it means the file system has to
> support both compressed and uncompressed files, but it's interesting.

You can also think of it as a step toward a hierarchical filesystem with the
files:
	1. uncompressed (with uncompressed inode)
	2. compressed on line (real disk space allocated)
	3. compressed nearline (only compressed inode on disk, with a
	reference to offline storage)

Obviously this is only for very large filesystems (we have one FS that
is currently between 100-200 TB in size when you include the migrated
storage).
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
