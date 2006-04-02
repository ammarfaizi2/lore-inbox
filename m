Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWDBLmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWDBLmR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 07:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWDBLmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 07:42:17 -0400
Received: from ns.suse.de ([195.135.220.2]:12987 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932314AbWDBLmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 07:42:17 -0400
Date: Sun, 2 Apr 2006 13:42:15 +0200
From: Olaf Hering <olh@suse.de>
To: John Mylchreest <johnm@gentoo.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, paulus@samba.org
Subject: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Message-ID: <20060402114215.GA30491@suse.de>
References: <20060401224849.GH16917@getafix.willow.local> <20060402085850.GA28857@suse.de> <20060402102259.GM16917@getafix.willow.local> <20060402102815.GA29717@suse.de> <20060402105859.GN16917@getafix.willow.local> <20060402111002.GA30017@suse.de> <20060402112002.GA3443@getafix.willow.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060402112002.GA3443@getafix.willow.local>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Apr 02, John Mylchreest wrote:

> Going from that, I can push a patch for gcc upstream to remove the
> __KERNEL__ dep, but gcc4.1 ships with ssp by standard, and the semantics
> between the IBM patch for SSP applied to gcc-3 and ggc-4 have changed.

gcc4.1 has no obvious problems with --enable-ssp

> -fno-stack-protector would work for gcc4, but for gcc3 it could still be
> patially enabled, and requires -fno-stack-protector-all. Mind If I ask
> whats incorrect about defining __KERNEL__ for the bootcflags?

arch/powerpc/boot is no kernel code, its supposed to be selfcontained.
Prepare a patch which uses the cc-option macro.
