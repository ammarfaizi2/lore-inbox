Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288502AbSAHWSq>; Tue, 8 Jan 2002 17:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288499AbSAHWSh>; Tue, 8 Jan 2002 17:18:37 -0500
Received: from mail.missioncriticallinux.com ([208.51.139.18]:8464 "EHLO
	missioncriticallinux.com") by vger.kernel.org with ESMTP
	id <S288503AbSAHWS0>; Tue, 8 Jan 2002 17:18:26 -0500
Message-ID: <3C3B702C.4BF3819@MissionCriticalLinux.com>
Date: Tue, 08 Jan 2002 14:18:20 -0800
From: Bruce Blinn <blinn@MissionCriticalLinux.com>
Organization: Mission Critical Linux
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.6-mclx-hp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Dave Anderson <anderson@mclinux.com>, linux-kernel@vger.kernel.org,
        blinn@mclinux.com
Subject: Re: [BUG][PATCH] 2.4.* mlockall(MCL_FUTURE) is broken -- child inherits 
 VM_LOCKED
In-Reply-To: <3C3B5D1B.45CBF593@mclinux.com> <3C3B6ADF.4AAABE58@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Dave Anderson wrote:
> >
> > In 2.4.*, mlockall(MCL_FUTURE) is erroneously inherited by child processes
> > across fork() and exec():
> 
> The Linux manpage says that it is not inherited across either.
> 
> However SUS says that it is not inherited across exec, and
> doesn't mention fork() at all.
> http://www.opengroup.org/onlinepubs/007908799/xsh/mlockall.html
> 
> So...  Shouldn't we be clearing it in the exec() path?
> 

But, the SUS documentation for fork() says that it does not inherit the
memory locks of the parent.  It explicitly mentions mlockall().

	http://www.opengroup.org/onlinepubs/007908799/xsh/fork.html
