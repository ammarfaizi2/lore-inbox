Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbULMRvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbULMRvc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 12:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbULMRvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 12:51:31 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:8643 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261284AbULMRv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 12:51:27 -0500
Message-ID: <41BDD659.9070500@sgi.com>
Date: Mon, 13 Dec 2004 11:50:17 -0600
From: Eric Sandeen <sandeen@sgi.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
CC: Patrick <nawtyness@gmail.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, Andrew Morton <akpm@osdl.org>,
       "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>,
       Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Unknown Issue.
References: <2E314DE03538984BA5634F12115B3A4E01BC4179@email1.mitretek.org>
In-Reply-To: <2E314DE03538984BA5634F12115B3A4E01BC4179@email1.mitretek.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Piszcz, Justin Michael wrote:

> Ah, good question, yes I used xfs_repair, at this point I knew I had to
> restore from backup and answered "y" to all questions.  I am not sure
> but I do not recall the log being dirty.

Hm, xfs_repair does not ask any questions.

> In the logs on my main machine, it showed the following when it
> attempted to mount the two filesystems (root and boot, /dev/hde4 and
> /dev/hde1 respectively).

> Dec  5 08:23:53 jpiszcz kernel: XFS internal error
> XFS_WANT_CORRUPTED_GOTO at line 1583 of file fs/xfs/xfs_alloc.c.  Caller
> 0xc021de57
(having trouble replaying the log here)

Ok, so XVM has found something wrong at this point.  Any chance the box 
had a power failure?  Write caches on ide drives can wreak havoc with 
journaling filesystems...  i.e. what happened between "the filesystem 
was working" and "i remounted the filesystem and got this"

>
> As far as bad disk/memory, I have tested both systems with memtest86 and
> the result was 0 errors, as far as the disks go, I have not experienced
> any problems with either of them until I moved to 2.6.9/2.6.10-rc{1,2}.

ok

-Eric
