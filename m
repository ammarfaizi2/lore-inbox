Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTIET4q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbTIET4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:56:45 -0400
Received: from ida.rowland.org ([192.131.102.52]:22788 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262813AbTIET4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:56:39 -0400
Date: Fri, 5 Sep 2003 15:56:37 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Andreas Dilger <adilger@clusterfs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: How can I force a read to hit the disk?
In-Reply-To: <20030905190902.GD24951@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44L0.0309051548020.678-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Sep 2003, Jörn Engel wrote:

> On Fri, 5 September 2003 14:49:15 -0400, Alan Stern wrote:
> > On Fri, 5 Sep 2003, Andreas Dilger wrote:
> > 
> > > If you open the file with O_DIRECT, it should read/write directly on the
> > > disk, and it will also invalidate any existing cache for the read/written
> > > area.
> > 
> > Unfortunately that's not a good solution for me.  The file has already 
> > been opened without O_DIRECT, and O_DIRECT wouldn't be appropriate because 
> > most of the time I do want I/O to go through the cache.  It's just on a 
> > few rare occasions that I need direct access to the disk.
> > 
> > Maybe simply opening a new struct file using O_DIRECT, for purposes of 
> > the verification, while keeping the old struct file around for other uses 
> > later, will work?  That would be awkward though -- and there's no 
> > guarantee that the original filename would still exist.  It would be a lot 
> > nicer to do everything using the original file reference.
> 
> Maybe these help you here:
> man 3 fdopen
> man 3 fileno
> 
> No filename needed for the second open.

I don't think they will help.  Apart from the fact that I'm working on a 
kernel module, not a user program, neither of these accepts options like 
O_DIRECT.

Alan Stern

