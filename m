Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWHVNl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWHVNl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 09:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWHVNl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 09:41:27 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:46242 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932245AbWHVNl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 09:41:26 -0400
Date: Tue, 22 Aug 2006 09:39:45 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] introduce kernel_execve function to replace __KERNEL_SYSCALLS__
Message-ID: <20060822133945.GA3813@ccure.user-mode-linux.org>
References: <20060819073031.GA25711@atjola.homenet> <1156231742.21752.101.camel@localhost.localdomain> <20060822080046.GA22572@atjola.homenet> <200608221207.00344.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608221207.00344.arnd@arndb.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 12:06:59PM +0200, Arnd Bergmann wrote:
> UML can be converted to use the syscall function provided by libc
> in order to call the host OS.

You're contemplating changing UML to do, e.g.
	syscall(NR_write, fd, buf, len)
instead of the current
	write(fd, buf,len)
?

That hardly seems like an improvement and it seems fairly unnecessary.

				Jeff
