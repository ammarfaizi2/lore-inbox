Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbUKCFKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbUKCFKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 00:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbUKCFKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 00:10:12 -0500
Received: from cantor.suse.de ([195.135.220.2]:28629 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261432AbUKCFKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 00:10:08 -0500
To: Daniel Egger <degger@fhm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8 and 2.6.9 Dual Opteron glitches
References: <5AC1EEB8-2CD7-11D9-BF00-000A958E35DC@fhm.edu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Nov 2004 06:06:51 +0100
In-Reply-To: <5AC1EEB8-2CD7-11D9-BF00-000A958E35DC@fhm.edu.suse.lists.linux.kernel>
Message-ID: <p737jp38qs4.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger <degger@fhm.edu> writes:

> 2) 64 bit kernel vgettimeofday panic: The kernel panics in
>     arch/x64_64/vsyscall.c:169 on boot.
> 
>    static int __init vsyscall_init(void)
>    {
>            if ((unsigned long) &vgettimeofday !=
> VSYSCALL_ADDR(__NR_vgettimeofday))
>                    panic("vgettimeofday link addr broken");
> 
>    Replacing those panic(s) by printk make the machine boot just fine
>    and also work (seemingly) without any problems under load.

Can you print the two values? I've never seen such a problem.
If it works then they must be identical, otherwise user space would
break very quickly.

-Andi
