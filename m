Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265755AbTIETJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265758AbTIETJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:09:55 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:7629 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265755AbTIETJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:09:52 -0400
Date: Fri, 5 Sep 2003 21:09:02 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: How can I force a read to hit the disk?
Message-ID: <20030905190902.GD24951@wohnheim.fh-wedel.de>
References: <20030905121522.B30448@schatzie.adilger.int> <Pine.LNX.4.44L0.0309051439560.678-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44L0.0309051439560.678-100000@ida.rowland.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 September 2003 14:49:15 -0400, Alan Stern wrote:
> On Fri, 5 Sep 2003, Andreas Dilger wrote:
> 
> > If you open the file with O_DIRECT, it should read/write directly on the
> > disk, and it will also invalidate any existing cache for the read/written
> > area.
> 
> Unfortunately that's not a good solution for me.  The file has already 
> been opened without O_DIRECT, and O_DIRECT wouldn't be appropriate because 
> most of the time I do want I/O to go through the cache.  It's just on a 
> few rare occasions that I need direct access to the disk.
> 
> Maybe simply opening a new struct file using O_DIRECT, for purposes of 
> the verification, while keeping the old struct file around for other uses 
> later, will work?  That would be awkward though -- and there's no 
> guarantee that the original filename would still exist.  It would be a lot 
> nicer to do everything using the original file reference.

Maybe these help you here:
man 3 fdopen
man 3 fileno

No filename needed for the second open.

Jörn

-- 
"Error protection by error detection and correction."
-- from a university class
