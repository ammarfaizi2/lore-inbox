Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267365AbUHSUY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267365AbUHSUY1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 16:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUHSUY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 16:24:26 -0400
Received: from imap.gmx.net ([213.165.64.20]:12183 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267365AbUHSUYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:24:24 -0400
X-Authenticated: #14776911
From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger@gmx.at>
Reply-To: stefandoesinger@gmx.at
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend 
Date: Thu, 19 Aug 2004 22:24:08 +0200
User-Agent: KMail/1.6.2
References: <41103F22.4090303@optonline.net>
In-Reply-To: <41103F22.4090303@optonline.net>
Cc: len.brown@intel.com, Linux Kernel list <linux-kernel@vger.kernel.org>,
       "Li, Shaohua" <shaohua.li@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408192224.08271.stefandoesinger@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch should fix multiple user-visible problems with the ACPI IRQ
> routing after S3 resume:
>
> "irq x: nobody cared"
> "my interrupts are gone"
>
> It probably applies to multiple bugzilla entries and mailing list posts.
>
> Tested on my machine, which is experiencing similar problems. Seems to
> work - although I get some non-fatal "nobody cared" messages that might
> be caused by the i8042 driver.
>
> Comments?
> Stefan, can you test this?
Sorry for the very late reply.

I tested with 2.6.8.1(I think your patch it included there) with strange 
results.

*It works fine if I unload ipw2100 before suspend and load it later
*In single user mode with ipw2100 loaded while S3, IRQ 11 is disabled on 
resume, IRQ is not disabled
*When the system is fully booted up, everything seems to work fine.

I'll test a little bit more and report the results.

Cheers,
Stefan
