Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWHTULW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWHTULW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 16:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWHTULW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 16:11:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:9380 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751197AbWHTULV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 16:11:21 -0400
X-Authenticated: #5039886
Date: Sun, 20 Aug 2006 22:11:18 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Chase Venters <chase.venters@clientec.com>, Andrew Morton <akpm@osdl.org>,
       Arnd Bergmann <arnd@arndb.de>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] introduce kernel_execve function to replace __KERNEL_SYSCALLS__
Message-ID: <20060820201118.GC11843@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Arjan van de Ven <arjan@infradead.org>,
	Chase Venters <chase.venters@clientec.com>,
	Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
	Russell King <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20060819073031.GA25711@atjola.homenet> <200608201237.13194.chase.venters@clientec.com> <20060820112523.f14fc6dc.akpm@osdl.org> <200608201333.02951.chase.venters@clientec.com> <20060820194552.GB11843@atjola.homenet> <1156103446.23756.60.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1156103446.23756.60.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.08.20 21:50:46 +0200, Arjan van de Ven wrote:
> \
> > Could we rename __syscall_return to IS_SYS_ERR (or whatever) and force
> > kernel syscall users to do the check? That way we could eliminate errno
> 
> s/users/user/ .. there's one left that should die out soon ;)
> 

Only one in unistd.h, but throughout the kernel there are quite a few
unless I'm missing something here:
doener@atjola:~/src/kernel/linux-2.6$ grep \ _syscall * -R | \
> grep -v define\\\|undef\\\|clobber | wc -l
116

Are these just going to be replaced by calls to sys_whatever?

Björn
