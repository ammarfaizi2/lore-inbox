Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269952AbUJHNQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269952AbUJHNQO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 09:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269958AbUJHNQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 09:16:14 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:6062 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269952AbUJHNQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 09:16:11 -0400
Subject: Re: how do you call userspace syscalls (e.g. sys_rename) from
	inside kernel
From: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041008130442.GE5551@lkcl.net>
References: <20041008130442.GE5551@lkcl.net>
Content-Type: text/plain
Date: Fri, 08 Oct 2004 10:07:04 -0300
Message-Id: <1097240824.4389.26.camel@lfs.barra.bali>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 14:04 +0100, Luke Kenneth Casson Leighton wrote:
> could someone kindly advise me on the location of some example code in
> the kernel which calls one of the userspace system calls from inside the
> kernel?
> 
> alternatively if this has never been considered before, please could
> someone advise me as to how it might be achieved?
> 

you cannot do that. For every sys_xx there is a do_xx, that can
be called from inside the kernel.

> thank you,
> 
> l.
> 
> [p.s. i found asm/unistd.h, i found the macros syscall012345
> etc., i believe i don't quite understand what these are for, and
> may be on the wrong track.]

These are are available for you to make syscalls from user mode
without library support (usually that brand new syscall you added).
They are basically wrappers that expand into C code. _syscallx, 
where x is the number of arguments the syscall needs.

> 

