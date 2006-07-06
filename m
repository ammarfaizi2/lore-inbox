Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWGFX5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWGFX5y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWGFX5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:57:53 -0400
Received: from relay02.pair.com ([209.68.5.16]:9232 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751093AbWGFX5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:57:52 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: Linux 2.6.17.4
Date: Thu, 6 Jul 2006 18:57:25 -0500
User-Agent: KMail/1.9.3
Cc: Greg KH <gregkh@suse.de>, "Scott J. Harmon" <harmon@ksu.edu>,
       linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
References: <20060706222704.GB2946@kroah.com> <20060706224614.GA3520@suse.de> <20060706234918.GB2037@1wt.eu>
In-Reply-To: <20060706234918.GB2037@1wt.eu>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607061857.49153.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 July 2006 18:48, Willy Tarreau wrote:
> Interestingly, 2.4 tests (arg2 !=0 && arg2 != 1) so from the code changes
> above, it looks like the value 2 was added on purpose, but for what ? Maybe
> the fix is not really correct yet ?

Hence the source of my curiosity. My prctl() manpage says that 2 makes a core 
that is only readable by root.

       PR_SET_DUMPABLE
              (Since  Linux 2.4) Set the state of the flag determining whether
              core dumps are produced for this process upon delivery of a sig-
              nal  whose  default  behaviour is to produce a core dump.  (Nor-
              mally this flag is set for a  process  by  default,  but  it  is
              cleared  when  a set-user-ID or set-group-ID program is executed
              and also by various system calls that  manipulate  process  UIDs
              and  GIDs).  In kernels up to and including 2.6.12, arg2 must be
              either 0 (process is not dumpable) or 1 (process  is  dumpable).
              Since  kernel 2.6.13, the value 2 is also permitted; this causes
              any binary which normally would not be dumped to be dumped read-
              able   by   root   only.    (See   also   the   description   of
              /proc/sys/fs/suid_dumpable in proc(5).)

> Cheers,
> Willy

Thanks,
Chase
