Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVIMUDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVIMUDm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVIMUDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:03:42 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:14611 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932175AbVIMUDl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:03:41 -0400
Date: Tue, 13 Sep 2005 22:04:29 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Cal Peake <cp@absolutedigital.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: more fallout from ATI Xpress timer workaround (was: Linux
 2.6.14-rc1)
Message-Id: <20050913220429.3d765e8f.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.61.0509130219330.9693@lancer.cnet.absolutedigital.net>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
	<Pine.LNX.4.61.0509130219330.9693@lancer.cnet.absolutedigital.net>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> More fallout from the change mentioned above.
> 
>   LD      .tmp_vmlinux1
> arch/i386/kernel/built-in.o(.init.text+0xd3a): In function 
> `parse_cmdline_early':
> : undefined reference to `disable_timer_pin_1'
> arch/i386/kernel/built-in.o(.init.text+0xd3f): In function 
> `parse_cmdline_early':
> : undefined reference to `disable_timer_pin_1'
> arch/i386/kernel/built-in.o(.init.text+0xd49): In function 
> `parse_cmdline_early':
> : undefined reference to `disable_timer_pin_1'
> make: *** [.tmp_vmlinux1] Error 1
> 
> This gets the kernel built:
> 
> disable_timer_pin_1 needs IO-APIC, not just local APIC.
> 
> Signed-off-by: Cal Peake <cp@absolutedigital.net>

Just hit the same problem, Cal's works for me. Can it be pushed to into
git?

Thanks,
-- 
Jean Delvare
