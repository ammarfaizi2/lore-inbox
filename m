Return-Path: <linux-kernel-owner+w=401wt.eu-S932260AbXAOL6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbXAOL6i (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 06:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbXAOL6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 06:58:38 -0500
Received: from [212.12.190.171] ([212.12.190.171]:32877 "EHLO raad.intranet"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932260AbXAOL6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 06:58:37 -0500
From: Al Boldi <a1426z@gawab.com>
To: roland@redhat.com
Subject: Re: [PATCH 1/11] Fix CONFIG_COMPAT_VDSO
Date: Mon, 15 Jan 2007 14:59:30 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200701151459.30258.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath wrote:
>
> I wouldn't mind if CONFIG_COMPAT_VDSO went away entirely.
> But if it's there, it should work properly.  Currently
> it's quite haphazard: both real vma and fixmap are
> mapped, both are put in the two different AT_* slots,
> sysenter returns to the vma address rather than the
> fixmap address, and core dumps yet are another story.
>
> This patch makes CONFIG_COMPAT_VDSO disable the real vma
> and use the fixmap area consistently.  This makes it
> actually compatible with what the old vdso implementation did.

I just tried your patch, but your changes seem to revert performance 
improvements achieved with 2.6.19, when vdso_enabled=1 and 
randomize_va_space=0.


Thanks!

--
Al

