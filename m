Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265244AbUAYVha (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 16:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265248AbUAYVha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 16:37:30 -0500
Received: from dsl081-085-091.lax1.dsl.speakeasy.net ([64.81.85.91]:27522 "EHLO
	mrhankey.megahappy.net") by vger.kernel.org with ESMTP
	id S265244AbUAYVh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 16:37:28 -0500
Message-ID: <401435CA.2020202@jpl.nasa.gov>
Date: Sun, 25 Jan 2004 13:31:54 -0800
From: Bryan Whitehead <driver@jpl.nasa.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Cambrant <tim@cambrant.com>
Cc: Bryan Whitehead <driver@megahappy.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.2-rc1-mm3] fs/xfs/xfs_log_recover.c
References: <20040125044859.8A67F13A354@mrhankey.megahappy.net> <20040125111129.GA29501@cambrant.com>
In-Reply-To: <20040125111129.GA29501@cambrant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Cambrant wrote:
> On Sat, Jan 24, 2004 at 08:48:59PM -0800, Bryan Whitehead wrote:
> 
>>This patch keeps the same functionality but removes the warning the compiler generates.
> 
> 
> I sent you a patch exactly like this a few days ago, but I don't know
> if you got it. This way is a lot more simple than the approach you went
> for in your last patch, but it really shouldn't matter at all. All it
> does is to clear a warning. One tip though, in SubmittingPatches you
> can read that the best way to create patches is by making them apply
> with the -p1 flag. This is done by including the actual kernel source
> directory when making the diff, such as this:

I didn't get it. Sorry.

> diff -up linux/fs/xfs/xfs_log_recover.c.orig linux/fs/xfs/xfs_log_recover.c
> 
> It doesn't matter what you named your kernel directory, since the -p1 flag
> ignores that name. Using this command will improve your chances of getting
> your patches included.
> 
> 
>                 Tim Cambrant

In Documentation/SubmittingPatches it says this:

To create a patch for a single file, it is often sufficient to do:

         SRCTREE= /devel/linux-2.4
         MYFILE=  drivers/net/mydriver.c

         cd $SRCTREE
         cp $MYFILE $MYFILE.orig
         vi $MYFILE      # make your change
         diff -up $MYFILE.orig $MYFILE > /tmp/patch

 From the example I am supposed to be in my source tree, not just 
outside it.

Does the documentation need to be changed? It seems everyone I've sent a 
patch to would like a patch that looks like "diff -up 
linux/fs/xfs/xfs_log_recover.c.orig linux/fs/xfs/xfs_log_recover.c" 
instead of "diff -up fs/xfs/xfs_log_recover.c.orig 
fs/xfs/xfs_log_recover.c".

If this is the case I wouldn't mind updating the docs and submitting a 
patch. ;)

-- 
Bryan Whitehead
Email:driver@megahappy.net
WorkE:driver@jpl.nasa.gov
