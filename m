Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWH0S3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWH0S3A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 14:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWH0S3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 14:29:00 -0400
Received: from cantor2.suse.de ([195.135.220.15]:47305 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932242AbWH0S27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 14:28:59 -0400
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit (ping)
References: <445B5524.2090001@gmail.com> <445BCA33.30903@zytor.com>
	<6.2.3.4.0.20060505204729.036dfdf8@pop-server.san.rr.com>
	<445C301E.6060509@zytor.com> <44AD583B.5040007@gmail.com>
	<44AD5BB4.9090005@zytor.com> <44AD5D47.8010307@gmail.com>
	<44AD5FD8.6010307@zytor.com>
	<9e0cf0bf0608031436x19262ab0rb2271b52ce75639d@mail.gmail.com>
	<44D278D6.2070106@zytor.com>
	<9e0cf0bf0608031542q2da20037h828f4b8f0d01c4d5@mail.gmail.com>
	<44D27F22.4080205@zytor.com> <44EF8E7D.5060905@gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 27 Aug 2006 20:28:57 +0200
In-Reply-To: <44EF8E7D.5060905@gmail.com>
Message-ID: <p73irkedod2.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev <alon.barlev@gmail.com> writes:

> Extending the kernel parameters to a 2048 bytes for
> boot protocol >=2.02 of i386, ia64 and x86_64 architectures for
> linux-2.6.18-rc4-mm2.
> 
> Current implementation allows the kernel to receive up to
> 255 characters from the bootloader. In current environment,
> the command-line is used in order to specify many values,
> including suspend/resume, module arguments, splash, initramfs
> and more. 255 characters are not enough anymore.

The last time I tried this on x86-64 lilo on systems that used EDD broke.
EDD uses part of the bootup page too. So most likely it's not that simple.

And please don't shout your subjects.

-Andi
