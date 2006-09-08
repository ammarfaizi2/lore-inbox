Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751965AbWIHAx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbWIHAx2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 20:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbWIHAx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 20:53:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29353 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751965AbWIHAx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 20:53:28 -0400
Date: Thu, 7 Sep 2006 17:53:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Metathronius Galabant" <m.galabant@googlemail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: top displaying 50% si time and 50% idle on idle machine
Message-Id: <20060907175323.57a5c6b0.akpm@osdl.org>
In-Reply-To: <1b270aae0609071108h22bc10b0v5d2227abfc66c53c@mail.gmail.com>
References: <1b270aae0609071108h22bc10b0v5d2227abfc66c53c@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006 20:08:53 +0200
"Metathronius Galabant" <m.galabant@googlemail.com> wrote:

> Hi,
> 
> Kernel 2.6.17.11 with tg3 network driver, NAPI enabled (Distro CentOS 4.4).
> top shows strangely 50% idle even if the machine is _completely_ idle.
> 
> top - 01:04:30 up 4 days, 12:05,  2 users,  load average: 0.00, 0.00, 0.00
> Tasks:  34 total,   2 running,  32 sleeping,   0 stopped,   0 zombie
> Cpu(s):  0.0% us,  0.0% sy,  0.0% ni, 50.0% id,  0.0% wa,  0.0% hi, 50.0% si
> Mem:   3634452k total,   313284k used,  3321168k free,    71308k buffers
> Swap:   505896k total,        0k used,   505896k free,   220272k cached
> 
> I find this pretty alarming - can somebody please enlighten me?
> Please include me on CC.

Do `ps aux', look for a process stuck in D state.

Do 

	echo t > /proc/sysrq-trigger
	dmesg -s 1000000 > foo

then edit foo, search for the process in D state (look for " D ") and send
that process's backtrace record.

Thanks. 
