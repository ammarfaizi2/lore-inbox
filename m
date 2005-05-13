Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbVEMMZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVEMMZF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 08:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVEMMZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 08:25:05 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:48823 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262348AbVEMMYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 08:24:48 -0400
Date: Fri, 13 May 2005 14:24:51 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Markus Klotzbuecher <mk@creamnet.de>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] mini_fo-0.6.0 overlay file system
Message-ID: <20050513122451.GD9255@wohnheim.fh-wedel.de>
References: <20050509183135.GB27743@mary> <20050512121842.GA20388@wohnheim.fh-wedel.de> <20050512164413.GA14099@mary> <2F200E69-465D-46ED-9D3A-5ED5C9FEAC9A@mac.com> <20050513080137.GA9255@wohnheim.fh-wedel.de> <7E4FD3AB-54F6-43D5-9340-ECEEA2E55C0B@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7E4FD3AB-54F6-43D5-9340-ECEEA2E55C0B@mac.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2005 07:26:14 -0400, Kyle Moffett wrote:
> 
> >It solves the biggest concern I had left for union mount.  Actually
> >implementing it, though, depends on quite a bit of infrastructure  
> >that just
> >doesn't exist yet.  Still, a very interesting idea.
> 
> For ext2/ext3, the sparse-file-support _does_ exist, so the only  
> major parts
> that need to be added are:
>     o An extra ext2/ext3 flag that indicates nonresidence (For both  
> sparse
>       files, normal files, and directories).
>     o VFS-level support for the union operation with hooks to let each
>       filesystem do something special.

That and replacing the page cache by something different.  Page cache
is referencing pages by inode,offset pairs.  Having a potentially
infinite amount of inodes to look at, in order, may require a tiny bit
of patching. ;)

Jörn

-- 
Linux [...] existed just for discussion between people who wanted
to show off how geeky they were.
-- Rob Enderle
