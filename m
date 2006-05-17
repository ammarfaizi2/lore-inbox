Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWEQSiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWEQSiM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWEQSiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:38:12 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:40006 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750890AbWEQSiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:38:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Wb5zQJj2+4++dDhLT6JlrOAGbJLIFhrPFkna5QB0woReYMM7+XRJPAzXtOJQWefrqm95oddRq/KaxJsuoTxNcasWmHO4/yWbPLGw9plkFW6wUbABrwHLXJwNrqtA+z1ubDlA3gmxs7EZ4B1KqlUxkAQe27ntGTXGyM+wGI4Bse8=
Date: Wed, 17 May 2006 15:38:04 -0300
From: Alberto Bertogli <albertito@gmail.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [UML] Problems building and running 2.6.17-rc4 on x86-64
Message-ID: <20060517183804.GE693@gmail.com>
References: <20060514182541.GA4980@gmail.com> <20060515033919.GD21383@ccure.user-mode-linux.org> <20060515152958.GA4553@gmail.com> <20060516191244.GB6337@ccure.user-mode-linux.org> <20060517023942.GI9066@gmail.com> <20060517181252.GA5896@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060517181252.GA5896@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 02:12:52PM -0400, Jeff Dike wrote:
> On Tue, May 16, 2006 at 11:39:42PM -0300, Alberto Bertogli wrote:
> > [42949374.050000] Kernel panic - not syncing: Kernel mode fault at addr 0x0, ip 0x4000f349
> 
> Err, there was a rather serious bug in that last patch.  Can you
> replace it with the version below and boot UML again?

Sure, here's the output.

Thanks,
		Alberto


[42949373.790000] VFS: Mounted root (ext3 filesystem) readonly.
[42949373.790000] Stub registers -
[42949373.790000]       0 - 8
[42949373.790000]       1 - 400040
[42949373.790000]       2 - 40001530
[42949373.790000]       3 - 2
[42949373.790000]       4 - fffffffd
[42949373.790000]       5 - 7
[42949373.790000]       6 - 5
[42949373.790000]       7 - 37
[42949373.790000]       8 - 3
[42949373.790000]       9 - 20611
[42949373.790000]       10 - 0
[42949373.790000]       11 - 2d
[42949373.790000]       12 - 11
[42949373.790000]       13 - 7f7fd0d179
[42949373.790000]       14 - 0
[42949373.790000]       15 - ffffffffffffffff
[42949373.790000]       16 - 4000eae0
[42949373.790000]       17 - 33
[42949373.790000]       18 - 10246
[42949373.790000]       19 - 7f7fd0d0d8
[42949373.790000]       20 - 2b
[42949373.790000]       21 - 2b4ba664a6d0
[42949373.790000]       22 - 0
[42949373.790000]       23 - 0
[42949373.790000]       24 - 0
[42949373.790000]       25 - 0
[42949373.790000]       26 - 0
[42949373.790000] Kernel panic - not syncing: handle_trap - failed to wait at end of syscall, errno = 0, status = 2943
[42949373.790000]
[42949373.790000]
[42949373.790000] Modules linked in:
[42949373.790000] Pid: 1, comm: init Not tainted 2.6.17-rc4
[42949373.790000] RIP: 0033:[<000000004000f349>]
[42949373.790000] RSP: 0000007f7fd0d0d8  EFLAGS: 00000246
[42949373.790000] RAX: 0000000000000000 RBX: 0000007f7fd0d0f0 RCX: ffffffffffffffff
[42949373.790000] RDX: 0000007f7fd0d3b0 RSI: 0000000040010900 RDI: 0000007f7fd0d0f0
[42949373.790000] RBP: 0000000000402240 R08: 0000000000000000 R09: 0000000000000000
[42949373.790000] R10: 0000000000000064 R11: 0000000000000246 R12: 0000007f7fd0d280
[42949373.790000] R13: 0000000040001530 R14: 0000000000400040 R15: 0000000000000008
[42949373.790000] Call Trace:
[42949373.790000] 61197c38:  [<6001a10a>] panic_exit+0x2a/0x50
[42949373.790000] 61197c48:  [<60044acc>] notifier_call_chain+0x1c/0x30
[42949373.790000] 61197c68:  [<600348cf>] panic+0xcf/0x170
[42949373.790000] 61197d48:  [<6002bf90>] userspace+0x260/0x2f0
[42949373.790000] 61197dc0:  [<60014010>] init+0x0/0x170
[42949373.790000] 61197dd8:  [<6001a7a2>] new_thread_handler+0x102/0x140
[42949373.790000]


