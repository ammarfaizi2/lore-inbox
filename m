Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992556AbWJTHws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992556AbWJTHws (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992572AbWJTHws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:52:48 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:7949 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S2992556AbWJTHwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:52:47 -0400
Date: Fri, 20 Oct 2006 08:52:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Albert Cahalan <acahalan@gmail.com>,
       Cal Peake <cp@absolutedigital.net>
Subject: Re: [CFT] Grep to find users of sys_sysctl.
Message-ID: <20061020075234.GA18645@flint.arm.linux.org.uk>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Albert Cahalan <acahalan@gmail.com>,
	Cal Peake <cp@absolutedigital.net>
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com> <Pine.LNX.4.64.0610181129090.3962@g5.osdl.org> <Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net> <20061018124415.e45ece22.akpm@osdl.org> <m17iyw7w92.fsf_-_@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0610191218020.32647@lancer.cnet.absolutedigital.net> <m1wt6v4gcx.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wt6v4gcx.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 01:05:18AM -0600, Eric W. Biederman wrote:
> Anyone who is interested in knowing if they have an application on
> their system that actually uses sys_sysctl please run the following grep.
> 
> find / -type f  -perm /111 -exec fgrep 'sysctl@@GLIBC' '{}' ';' 
> 
> The -perm /111 is an optimization to only look at executable files,
> and may be omitted if you are patient.
> 
> Currently I don't expect anyone to find a match anywhere except in libpthreads,
> if you find any others please let me know.

glibc on ARM _requires_ sys_sysctl for userspace ioperm, inb, outb etc
emulation.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
