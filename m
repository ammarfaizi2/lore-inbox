Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268831AbUJKL7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268831AbUJKL7X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 07:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268845AbUJKL7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 07:59:23 -0400
Received: from zero.aec.at ([193.170.194.10]:62223 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268831AbUJKL7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 07:59:21 -0400
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
cc: linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: ctx64 is not initiated in sys32_io_setup
References: <2O4lX-4Kf-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 11 Oct 2004 13:59:10 +0200
In-Reply-To: <2O4lX-4Kf-9@gated-at.bofh.it> (Yanmin Zhang's message of "Mon,
 11 Oct 2004 11:10:09 +0200")
Message-ID: <m34ql1wjn5.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Zhang, Yanmin" <yanmin.zhang@intel.com> writes:

> Kernel 2.6.9-rc3-mm3 has a bug in function sys32_io_setup in file
> arch/x86_64/ia32/sys_ia32.c. Local variable ctx64 is not initiated
> before sys32_io_setup calls sys_io_setup. If ctx64 is not zero, and
> sys_io_setup will return -EINVAL. Generic function compat_sys_io_setup
> has not the bug. 
>
> Here is the patch against 2.6.9-rc3-mm3. Just use compat_sys_io_setup to
> replace sys32_io_setup.

Thanks merged (by hand because your patch was MIME damaged) 
Please put me in cc in future x86-64 patches, otherwise it's 
possible that I miss them.

-Andi


