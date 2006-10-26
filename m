Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423521AbWJZOS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423521AbWJZOS4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 10:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423522AbWJZOS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 10:18:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58271 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423521AbWJZOS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 10:18:56 -0400
Subject: Re: Another kernel releated GPL ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: markh@compro.net
Cc: Erik Mouw <erik@harddisk-recovery.com>, dmarkh@cfl.rr.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4540B414.7040406@compro.net>
References: <4540839C.6010302@cfl.rr.com>
	 <1161861128.12781.28.camel@localhost.localdomain>
	 <45409BFA.8000507@compro.net>
	 <20061026121041.GB12420@harddisk-recovery.com>
	 <4540B414.7040406@compro.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Oct 2006 15:21:48 +0100
Message-Id: <1161872508.12781.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-26 am 09:11 -0400, ysgrifennodd Mark Hounschell:
> Some code is added directly to the kernel source tree. A user land library is
> written to access the changes. It is not GPL or LGPL. Simple scenario. No? I
> thought so at least.

It isn't a simple scenario because it depends what you are adding and
how the two parts interact, eg how generic they are.

Take a memory allocator - if I put a malloc implementation in the kernel
for some strange reason that provides malloc/free/realloc then a library
making use of those clearly isn't very closely tied - they are generic
functions.

Now suppose I have a device driver that is part kernel and part user
space that calls from one to the other for very specific functions that
are only of use to that driver.

In the usual case it doesn't matter, much stuff is GPL anyway, and for
the usual system calls/C library stuff not only is the law probably
fairly well established but there is an explicit statement with the
kernel that we don't want to claim such rights for a normal system call
which would guide a Judge if a case ever came up.


Alan

