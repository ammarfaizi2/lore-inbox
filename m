Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbWJFQdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbWJFQdF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422663AbWJFQdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:33:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:41567 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751596AbWJFQdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:33:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=QeotYJBfABMawyj5rxCPrxwLpzOWqp/NHj5iGCJDYgu+d4Da5wZCU83lqg4nyC/I6pSUHLs41YmwcI8GQZ6eh+E1jTkg9WbwO9nsvkDfXfrbd7Enmnjpu+bRLqYWS3Pd7+gKA21biH0uAzirY21DqSzZ0ob7I7DI7F50cjMtpA8=
Date: Fri, 6 Oct 2006 16:32:38 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Read Only File System?
Message-ID: <20061006163238.GK352@slug>
References: <45268412.3040400@perkel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45268412.3040400@perkel.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 09:28:02AM -0700, Marc Perkel wrote:
> Not sure where to ask this question so I'll try here. I have a Raid 0 EXT3 file system that is coming up read 
> only. I don't think it's raid related but not sure why it's stuck on read only.
> 
> When I run mount it shows:
> /dev/md0 on /data type ext3 (rw,noatime)
> 
> But when I attempt (running as root) to change anything I get:
> touch: cannot touch `x': Read-only file system
> 
> When I list the directory I get this:
> drwxr-xr-x    8 root root  4096 Sep 29 15:15 .
> drwxr-xr-x   45 root root  4096 Oct  4 10:42 ..
> drwxr-xr-x    4 root root  4096 Sep 11 03:17 critical
> drwx------    2 root root 16384 Sep 10 22:37 lost+found
> drwxr-xr-x   19 root root  4096 Sep 11 02:07 mirror
> dr-x------   14 root root  4096 Sep  9 09:52 Robin
> drwxr-xr-x    7 root root  4096 Oct  5 02:16 snapshot
> drwxrwxr-x+ 289 root root 12288 Oct  1 03:20 www
> 
> Note the weird permissions on Robin. This happened because I was trying to save data from a crashed Windows 
> NT system and I used rsync to copy the data over. And I noticed the problem around the same time.
> 
> So - what can I do to fix this?
Does your dmesg have some info on this?

Regards,
Frederik
