Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbVHPRe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbVHPRe6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 13:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbVHPRe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 13:34:57 -0400
Received: from chello062178225197.14.15.tuwien.teleweb.at ([62.178.225.197]:37563
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1030257AbVHPRe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 13:34:57 -0400
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process
From: Wieland Gmeiner <e8607062@student.tuwien.ac.at>
Reply-To: e8607062@student.tuwien.ac.at
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Elliot Lee <sopwith@redhat.com>
In-Reply-To: <20050813221148.GA20060@kroah.com>
References: <1123868902.10923.5.camel@w2> <20050813221148.GA20060@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Aug 2005 19:34:34 +0200
Message-Id: <1124213674.9316.15.camel@w2>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-13 at 15:11 -0700, Greg KH wrote:
> On Fri, Aug 12, 2005 at 07:48:22PM +0200, Wieland Gmeiner wrote:
> > @@ -294,3 +294,4 @@ ENTRY(sys_call_table)
> >  	.long sys_inotify_init
> >  	.long sys_inotify_add_watch
> >  	.long sys_inotify_rm_watch
> > +        .long sys_getprlimit
> 
> Please follow the proper kernel coding style when writing new kernel
> code...

Hm, Documentation/CodingStyle suggests using descriptive names, so
something like getrlimit(...)/getrlimit_per_process(pid_t pid, ...)
would be more appropriate?

I thought getrlimit(...)/getprlimit(pid_t pid, ...) would be a good
choice as getgid(void)/getpgid(pid_t pid) already exists in Linux which
have the same naming scheme.

Or would something like
getrlimit/getrlimitpid (like wait(void)/waitpid(pid)) or
getrlimit/getrlimit2 (like getpgrp(void)/getpgrp2(pid) in HP-UX)
be preferred?

What would you suggest?

Thanks,
Wieland

