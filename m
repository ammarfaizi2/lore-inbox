Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTJQXBD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 19:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTJQXBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 19:01:03 -0400
Received: from [80.250.191.80] ([80.250.191.80]:28857 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261245AbTJQXBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 19:01:01 -0400
Date: Sat, 18 Oct 2003 03:05:08 +0400
From: Alex Tomas <alex@clusterfs.com>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EXT3 extents against 2.6.0-test7
Message-Id: <20031018030508.4c168433.alex@clusterfs.com>
In-Reply-To: <3F905D7D.9030602@wmich.edu>
References: <20031013222747.37f5ee7b.alex@clusterfs.com>
	<3F8B1BA1.4020800@wmich.edu>
	<20031014212359.42243025.alex@clusterfs.com>
	<3F9043E7.3070606@wmich.edu>
	<20031018001001.25e85002.alex@clusterfs.com>
	<3F904D7F.50403@wmich.edu>
	<20031018004152.6aa9e9c3.alex@clusterfs.com>
	<3F905D7D.9030602@wmich.edu>
Organization: CFS
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Oct 2003 17:22:05 -0400
Ed Sweetman <ed.sweetman@wmich.edu> wrote:

> none of my directories have more than 60 or so entries.  I keep 
> everything very organized on my hdds.  The largest directories would be 
> the ones holding the largest files but that maxes out at around 60 file 
> entries.  i formatted those partitions with a 4KB inode size.

oh. this seems very confusing for me. extents crashed during readdir() syscall.
4k block may contain upto 60 entries with 60chars length. even if your dir was
larger I don't think it was >16k. so, I really do believe all the extents were
placed in inode body (zero tree depth). also, directory grows in linear manner
only. so, this code patch is very very simple and quite good tested. thus it 
really seems like a corruption, not an error in logic. let me cook a patch that
will show more info.  

also, it's very interesting how is it difficult to reproduce on your box?

thanks!

--
with best regards, Alex
