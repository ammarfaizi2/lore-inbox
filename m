Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbTJQUhj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 16:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263524AbTJQUhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 16:37:39 -0400
Received: from [80.250.191.80] ([80.250.191.80]:7864 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S263523AbTJQUhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 16:37:38 -0400
Date: Sat, 18 Oct 2003 00:41:52 +0400
From: Alex Tomas <alex@clusterfs.com>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EXT3 extents against 2.6.0-test7
Message-Id: <20031018004152.6aa9e9c3.alex@clusterfs.com>
In-Reply-To: <3F904D7F.50403@wmich.edu>
References: <20031013222747.37f5ee7b.alex@clusterfs.com>
	<3F8B1BA1.4020800@wmich.edu>
	<20031014212359.42243025.alex@clusterfs.com>
	<3F9043E7.3070606@wmich.edu>
	<20031018001001.25e85002.alex@clusterfs.com>
	<3F904D7F.50403@wmich.edu>
Organization: CFS
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Oct 2003 16:13:51 -0400
Ed Sweetman <ed.sweetman@wmich.edu> wrote:

> How am i supposed to know which directory in the fs this corruption 
> takes place in?   I can tell you the size of the partitions that have 
> extents enabled, From that error message i dont even know which 
> partition it was.  And judging by the dmesg last modified time, this 
> happened 2 days ago

OK. the question wasn't clear.

1) could you _estimate_ max directory size or number of entries in single
   directory on your filesystems, please? had you large directories?
   100, 300, 500 or more entries?

2) did you use 2.6.0-test7+extents or some another patches?

3) could you describe workload. knowing it I'd try to reproduce this


> Isn't it possible though that this happened in one of the non-extents 
> enabled partitions though?  Since they still have the ability to read 
> extents in files, they have to try and look them up every time for 
> everything dont they?  Anyways, the two partitions above are the only 
> ones i actually enable extents on.
> 

extents take place only if flag in inode->i_flags is set. that flag can
be set only during inode creation on extents-enabled filesystem.

with best wishes, Alex
