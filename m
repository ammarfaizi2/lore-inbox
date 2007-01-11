Return-Path: <linux-kernel-owner+w=401wt.eu-S932807AbXAKWrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807AbXAKWrD (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 17:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932809AbXAKWrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 17:47:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59397 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932807AbXAKWrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 17:47:01 -0500
Message-ID: <45A6BE5C.9040904@redhat.com>
Date: Thu, 11 Jan 2007 17:46:52 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061215)
MIME-Version: 1.0
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: mmap / mtime updates
References: <20070109220940.GA16978@amelek.gda.pl>
In-Reply-To: <20070109220940.GA16978@amelek.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marek Michalkiewicz wrote:
> Hello,
>
> What is the current status of the bug where modifications to file
> contents made via mmap fail to update mtime of the file?
>
> This was discussed a few months ago in this thread:
>
> http://lkml.org/lkml/2006/5/17/138
>
> where patches have been posted, but it seems that no final solution
> has been agreed on and applied to the kernel tree.  Updating ctime
> and mtime appears to be required by the standard:
>
>   http://www.opengroup.org/onlinepubs/009695399/functions/mmap.html
>
>   The st_ctime and st_mtime fields of a file that is mapped with
>   MAP_SHARED and PROT_WRITE shall be marked for update at some point
>   in the interval between a write reference to the mapped region and
>   the next call to msync() with MS_ASYNC or MS_SYNC for that portion
>   of the file by any process.
>
> and failing to do it can lead to potential data loss as well, if
> modified files are not backed up (I'm seeing the problem with Samba
> tdb files not being backed up by rsnapshot, for example).

I am working on porting the patches to the current upstream kernel.
As soon as I complete this work, then I will repost the patch and
we'll see where things go then.

    Thanx...

       ps
