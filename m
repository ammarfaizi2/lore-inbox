Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbRCBTlj>; Fri, 2 Mar 2001 14:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129468AbRCBTla>; Fri, 2 Mar 2001 14:41:30 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:32025 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129464AbRCBTlW>;
	Fri, 2 Mar 2001 14:41:22 -0500
Message-Id: <200103021941.f22Jf3e02127@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Chris Mason <mason@suse.com>
cc: Steve Lord <lord@sgi.com>, Jeremy Hansen <jeremy@xxedgexx.com>,
        linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's 
In-Reply-To: Message from Chris Mason <mason@suse.com> 
   of "Fri, 02 Mar 2001 14:38:56 EST." <412990000.983561936@tiny> 
Date: Fri, 02 Mar 2001 13:41:02 -0600
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> On Friday, March 02, 2001 01:25:25 PM -0600 Steve Lord <lord@sgi.com> wrote:
> 
> >> For why ide is beating scsi in this benchmark...make sure tagged queueing
> >> is on (or increase the queue length?).  For the xlog.c test posted, I
> >> would expect scsi to get faster than ide as the size of the write
> >> increases.
> > 
> > I think the issue is the call being used now is going to get slower the
> > larger the device is, just from the point of view of how many buffers it
> > has to scan.
> 
> filemap_fdatawait, filemap_fdatasync, and fsync_inode_buffers all restrict
> their scans to a list of dirty buffers for that specific file.  Only
> file_fsync goes through all the dirty buffers on the device, and the ext2
> fsync path never calls file_fsync.
> 
> Or am I missing something?
> 
> -chris
> 
> 

No you are not, I will now go put on the brown paper bag.....

The scsi thing is wierd though, we have seen it here too.

Steve



