Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319247AbSIFQLp>; Fri, 6 Sep 2002 12:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319155AbSIFQLo>; Fri, 6 Sep 2002 12:11:44 -0400
Received: from citi.umich.edu ([141.211.92.141]:48450 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id <S319229AbSIFQLb>;
	Fri, 6 Sep 2002 12:11:31 -0400
Date: Fri, 6 Sep 2002 12:16:05 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <3D7876DB.4C0BBF1@aitel.hist.no>
Message-ID: <Pine.BSO.4.33.0209061214420.10353-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2002, Helge Hafting wrote:

> Chuck Lever wrote:
> Perhaps this explains my nfs problem. (2.5.32/33 UP, preempt, no
> highmem)
> Soemtimes, when editing a file on nfs, the file disappears
> from the server.  The client believes it is there
> until an umount+mount sequence.  It doesn't happen
> for all files, but it is 100% reproducible for those affected.
>
> Editing changes the directory when the editor makes a backup
> copy, the old directory is kept around wrongly, and so the
> save into the existing file silently fails because
> wrong directory information from cache is used?

that sounds very similar, it is probably the same bug.

	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

