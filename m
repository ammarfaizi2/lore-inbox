Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264006AbUD0Lrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264006AbUD0Lrg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 07:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264014AbUD0Lrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 07:47:36 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:60070 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264006AbUD0Lre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 07:47:34 -0400
Date: Tue, 27 Apr 2004 13:47:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH COW] sys_copyfile
Message-ID: <20040427114728.GB32554@wohnheim.fh-wedel.de>
References: <20040426092045.GC895@wohnheim.fh-wedel.de> <20040427113052.GD6620@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040427113052.GD6620@harddisk-recovery.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 April 2004 13:30:52 +0200, Erik Mouw wrote:
> On Mon, Apr 26, 2004 at 11:20:45AM +0200, J?rn Engel wrote:
> > Adds a new syscall, copyfile() which does as the name sais.
> 
> I think it's actually better to use sendfile() rather then creating a
> new syscall:
> 
>   ssize_t sendfile(int out_fd, int in_fd, off_t *offset, size_t count)
> 
> In that way you can create the file in the usual way and copy the
> contents with an already existing syscall.
> 
> IMHO sendfile() has been a wrong name in the first place, copyfd()
> would have been better. Why limit it to network traffic only?

See an earlier patch of mine. :)

Also, my grand goal is copy on write (cow) for files.  copyfile() is
just another step in that direction.

Jörn

-- 
Rules of Optimization:
Rule 1: Don't do it.
Rule 2 (for experts only): Don't do it yet.
-- M.A. Jackson 
