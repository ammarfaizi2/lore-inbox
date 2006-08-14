Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751783AbWHNCBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbWHNCBU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 22:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWHNCBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 22:01:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:42703 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751783AbWHNCBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 22:01:20 -0400
Date: Mon, 14 Aug 2006 12:00:32 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Avuton Olrich <avuton@gmail.com>, "Tony. Ho" <linux@idccenter.cn>,
       linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Message-ID: <20060814120032.E2698880@wobbly.melbourne.sgi.com>
References: <3aa654a40608072039r2b5c5a19hbd3e68e4fee40869@mail.gmail.com> <20060808134438.E2526901@wobbly.melbourne.sgi.com> <9a8748490608080137k596a6290r3567096668449a64@mail.gmail.com> <20060808185405.B2528231@wobbly.melbourne.sgi.com> <9a8748490608100431m244207b1v9c9c5087233fcf3a@mail.gmail.com> <20060811083546.B2596458@wobbly.melbourne.sgi.com> <9a8748490608101544n29f863e7o7584ac64f1d4c210@mail.gmail.com> <9a8748490608101552w12822fa6m415a5fb5537c744d@mail.gmail.com> <9a8748490608110133v5f973cf6w1af340f59bb229ec@mail.gmail.com> <9a8748490608110325k25c340e2yac925eb226d1fe4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9a8748490608110325k25c340e2yac925eb226d1fe4f@mail.gmail.com>; from jesper.juhl@gmail.com on Fri, Aug 11, 2006 at 12:25:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 12:25:03PM +0200, Jesper Juhl wrote:
> I didn't capture all of the xfs_repair output, but I did get this :
> ...
> Phase 4 - check for duplicate blocks...
>         - setting up duplicate extent list...
>         - clear lost+found (if it exists) ...
>         - clearing existing "lost+found" inode
>         - deleting existing "lost+found" entry
>         - check for inodes claiming duplicate blocks...
>         - agno = 0
>         - agno = 1
>         - agno = 2
>         - agno = 3
>         - agno = 4
>         - agno = 5
>         - agno = 6
> LEAFN node level is 1 inode 412035424 bno = 8388608

Ooh.  Can you describe this test case you're using?  Something with
a bunch of renames in it, obviously, but I'd also like to be able to
reproduce locally with the exact data set (file names in particular),
if at all possible.

thanks!

-- 
Nathan
