Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTJ2TmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 14:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbTJ2TmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 14:42:08 -0500
Received: from zero.aec.at ([193.170.194.10]:40709 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261351AbTJ2TmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 14:42:06 -0500
To: Mark Lane <mark@harddata.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 and Athlon64
From: Andi Kleen <ak@muc.de>
Date: Wed, 29 Oct 2003 20:41:55 +0100
In-Reply-To: <M4ba.8dv.3@gated-at.bofh.it> (Mark Lane's message of "Wed, 29
 Oct 2003 20:30:12 +0100")
Message-ID: <m3llr3zv98.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <M4ba.8dv.3@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lane <mark@harddata.com> writes:

> I am having trouble compiling the 2.4.22 kernel for x86-64 non-smp. I
> can compile the smp kernel but not the regular kernel.

2.4.22 broke the ACPI compilation in the last minute. You can either
disable ACPI or apply ftp://ftp.x86-64.org/pub/linux/v2.4/acpi-2.4.22-hotfix

> It seems that ksyms.c for x86-64 is looking for some smp stuff from
> the errors I am getting.
>
> I have tried 2.4.23-8 and the problem seems gone but I get an error
> when linking fs/fs.o into vmlinux. I have attached the errors I
> received.

fs/fs.o(.text+0x1429f): In function `dput':
: undefined reference to `atomic_dec_and_lock'

either your tree is unclean (do a make mrproper and try again)
or your compiler does not properly inline. What compiler are you using?

-Andi
