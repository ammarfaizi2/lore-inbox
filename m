Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269944AbRHMHni>; Mon, 13 Aug 2001 03:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269946AbRHMHn2>; Mon, 13 Aug 2001 03:43:28 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:48889 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S269944AbRHMHnS>;
	Mon, 13 Aug 2001 03:43:18 -0400
Date: Mon, 13 Aug 2001 17:42:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Riley Williams <rhw@MemAlpha.CX>
Cc: monniaux@di.ens.fr, linux-kernel@vger.kernel.org
Subject: Re: APM poweroff under Linux 2.4.7 / 2.4.2 RH 7.1
Message-Id: <20010813174204.7cea2724.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.33.0108090822460.10432-300000@infradead.org>
In-Reply-To: <20010809170246.04c44c35.sfr@canb.auug.org.au>
	<Pine.LNX.4.33.0108090822460.10432-300000@infradead.org>
X-Mailer: Sylpheed version 0.5.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Riley,

On Thu, 9 Aug 2001 08:34:51 +0100 (BST) Riley Williams <rhw@MemAlpha.CX> wrote:
> 
> Of the many patches theein, the enclosed TWO are the only ones that
> touch apm.c so they are the patches you may need to consider. I'd
> certainly be interested in your comments thereon.

I have seen both these patches.  The first is not relevant (it just changes
how we register a sysreq key).  The second has the effect of NOT using
the real mode power off code unless both CONFIG_APM_REAL_MODE_POWER_OFF
was set at kerne configure time AND "apm=realmode" was specified on the
kernel command line at boot time.

So those having trouble powering off with 2.4.[78] when the Red Hat kernel
did power off, should try building their kernels with
CONFIG_APM_REAL_MODE_POWER_OFF NOT selected.

Cheers,
Stephen Rothwell
IBM OzLabs - Linux Technology Centre
