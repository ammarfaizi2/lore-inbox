Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbULMREs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbULMREs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 12:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbULMREs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 12:04:48 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:63925 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261287AbULMRE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 12:04:28 -0500
Message-ID: <41BDCB8F.5080902@sgi.com>
Date: Mon, 13 Dec 2004 11:04:15 -0600
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
References: <2E314DE03538984BA5634F12115B3A4E01BC4175@email1.mitretek.org>
In-Reply-To: <2E314DE03538984BA5634F12115B3A4E01BC4175@email1.mitretek.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My first thought is that perhaps the filesystem has shut down due to 
some error (memory corruption, bad disk, xfs bug...); did you check your 
log messages?

Justin, when you mentioned that you used xfs' fsck, I guess you used 
xfs_repair.  Was the log clean when you ran it, or did you force repair 
to zero out the log?  That could explain the large lost+found/ when you 
were done...

Patrick, can you reproduce on a non-gentoo kernel?  That'd be the first 
step for this audience.

-Eric

Piszcz, Justin Michael wrote:
> Patrick,
> 
> I had the same problem on two machines with XFS.  Both slackware-current
> machines.  The kernel on the Dell GX1 was built with GCC-3.4.2 and on my
> main box was GCC-3.4.3.
> 
> There seems to be a bug in XFS with some configurations of 2.6.9 and
> 2.6.10-rc series.
> 
> After re-installing Slackware-10.0 and upgrading to -current, I have
> installed 2.6.10-rc3 and so far, I have not been able to reproduce the
> problem.
> 
> Some questions for you:
> 
> 1] What kernel are you running?
> 2] What did you last change before you started getting these errors?
> 
> As far as severity goes, I ran XFS' fsck from a KNOPPIX CD and as a
> result, I had about 500-600mb of files in my /lost+found directory when
> it was finished.  Files were missing from all parts of the file system.
> I had to restore from backup.  I would say stick with your previous
> 2.6.9 configuration (if you were running it) or go back to 2.6.8.1, some
> 2.6.9 configurations and 2.6.10-rc1 and/or 2.6.10-rc2 definitely cause
> file corruption with XFS.  So far, however, I have not been able to
> reproduce the error with 2.6.10-rc3.
> 
> Justin.
> 
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Patrick
> Sent: Sunday, December 12, 2004 4:15 PM
> To: linux-kernel@vger.kernel.org
> Subject: Unknown Issue.
> 
> Hi, 
> 
> I've got a computer running gentoo, on a clean install where i've got
> an odd problem :
> 
> after a while, the computer refuses to spawn processes anymore : 
> 
> -/bin/bash: /bin/ps: Input/output error
> -/bin/bash: /usr/bin/w: Input/output error
> -/bin/bash: /bin/df: Input/output error
> -/bin/bash: /bin/mount: Input/output error
> 

