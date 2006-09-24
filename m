Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWIXTf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWIXTf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 15:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWIXTf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 15:35:28 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45481 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751307AbWIXTf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 15:35:27 -0400
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Ulrich Drepper <drepper@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4516B2C8.4050202@aknet.ru>
References: <45150CD7.4010708@aknet.ru>
	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>
	 <451555CB.5010006@aknet.ru>
	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>
	 <1159037913.24572.62.camel@localhost.localdomain>
	 <45162BE5.2020100@aknet.ru>
	 <1159106032.11049.12.camel@localhost.localdomain>
	 <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com>
	 <4516B2C8.4050202@aknet.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 24 Sep 2006 20:59:38 +0100
Message-Id: <1159127978.11049.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-09-24 am 20:31 +0400, ysgrifennodd Stas Sergeev:
> 1. mprotect() the existing mapping to PROT_EXEC and bypass the
> checks (but you can easily restrict that by patching mprotect()).

Bug: To be fixed

> 2. Do the anonymous mmap with PROT_EXEC set, then simply read()
> the code there, then execute. This you *can not* restrict!

Its a non-finite turing machine, you can also execute an interpreter.

> Now, the breakage of the properly-written programs forces people
> to stop using "noexec" on /dev/shm-mounted tmpfs. As far as I

But you've already just argued that this isn't useful anyway ?

> understand, having the single writeable and executable mountpoint
> is almost as bad as having all of them. The attacker will now simply
> put his binary into /dev/shm.

SELinux

