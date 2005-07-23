Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVGWGAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVGWGAV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 02:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVGWGAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 02:00:21 -0400
Received: from svr68.ehostpros.com ([67.15.48.48]:30897 "EHLO
	svr68.ehostpros.com") by vger.kernel.org with ESMTP id S261325AbVGWGAT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 02:00:19 -0400
From: "Amit S. Kale" <amitkale@linsyssoft.com>
Organization: LinSysSoft Technologies Pvt Ltd
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: CheckFS: Checkpoints and Block Level Incremental Backup (BLIB)
Date: Sat, 23 Jul 2005 11:30:07 +0530
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507231130.07208.amitkale@linsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr68.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linsyssoft.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ted,

Thanks for your suggestions and help.

We started it from 2.6.7 last year and then it was sitting idle for several 
months for lack of resources. We'll go back to that version and generate a 
diff that's easier to read.

Yes, changing the name has made the task of rebasing wrt. changing kernels lot 
difficult. Our original intention was to make testing easier by keeping ext3 
and checkfs filesystems in the same kernel. Had we continued it at that 
point, we would have posted differences wrt. ext3 sources themselves. There 
was compelling reason to change the name.

Regards.
-Amit


> This looks like very interesting technology, but out of curiosity, why
> did you develop this as separate filesystem with a new filesystem
> name, and doing a global search-and-replace of "ext3" with "checkfs"
> in the source files, instead of simply just modifying ext3 and posting
> diffs? Especially since that the apparent intention is to keep ext3
> compatibility using the same ext3 magic numbers, data formats, and
> user-mode utilities.
>
> I'll reserve the superblock fields and compatibility bitmap fields
> used by your code in e2fsprogs to help avoid the possibility of other
> folks working on ext3 extensions from colliding with the codepoints
> which you "borrowed", but in the future, it would be good if people
> contact me in advance so I ensure that there are no collisions with
> other development groups.
>
> What version of the source base did you originally fork checkfs from?
> That way we can do a "s/checkfs/ext3/g" search and replace and then
> generate some diffs to see what you changed, or alternatively, it
> would be even better if you minimized differences between your version
> and mainline and generated the diffs yourself.
> 
> Thanks, regards,
> 
> - Ted
