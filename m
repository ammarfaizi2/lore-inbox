Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWBSGeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWBSGeK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 01:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWBSGeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 01:34:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47749 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751045AbWBSGeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 01:34:08 -0500
Date: Sat, 18 Feb 2006 22:32:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: stern@rowland.harvard.edu, pavel@suse.cz, torvalds@osdl.org,
       mrmacman_g4@mac.com, alon.barlev@gmail.com,
       linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Subject: Re: Flames over -- Re: Which is simpler?
Message-Id: <20060218223221.6df891d3.akpm@osdl.org>
In-Reply-To: <43F80A06.2090209@cfl.rr.com>
References: <20060217210445.GR3490@openzaurus.ucw.cz>
	<Pine.LNX.4.44L0.0602181531290.4115-100000@netrider.rowland.org>
	<20060218160242.7d2b5754.akpm@osdl.org>
	<43F80A06.2090209@cfl.rr.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> wrote:
>
> > But I suspect we could do an even better job if we did that in userspace.
>  > 
>  > The logic to determine whether the new device is the same as the old device
>  > can be arbitrarily complex, with increasing levels of success.  Various
>  > heuristics can be applied, some of which will involve knowledge of
>  > filesystem layout, etc.
>  > 
>  > So would it not be possible to optionally punt the device naming decision
>  > up to the hotplug scripts?  So code up there can go do direct-IO reads of
>  > the newly-present blockdev, use filesytem layout knowledge, peek at UUIDs,
>  > superblocks, disk labels, partition tables, inode numbering, etc?  Go look
>  > up a database, work out what that filesystem was doing last time we saw it,
>  > etc?
>  > 
>  > We could of course add things to the filesystems to help this process, but
>  > it'd be good if all the state tracking and magic didn't have to be locked
>  > up in the kernel.
> 
> 
>  Hrm... interesting but sounds like that could be sticky.  For instance, 
>  what if the user script that does the verifying happens to be ON the 
>  volume to be verified?

Well that would be a bug.  Solutions would be a) don't put the scripts on a
removable/power-downable device or b) use tmpfs.
