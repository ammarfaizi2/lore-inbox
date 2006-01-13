Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932681AbWAMCb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbWAMCb4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 21:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbWAMCbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 21:31:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52713 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932681AbWAMCby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 21:31:54 -0500
Date: Thu, 12 Jan 2006 18:31:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Takashi Sato" <sho@tnes.nec.co.jp>
Cc: torvalds@osdl.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: [PATCH 1/3] Fix problems on multi-TB filesystem and file
Message-Id: <20060112183124.5b9b5565.akpm@osdl.org>
In-Reply-To: <000001c611df$5556aa00$4168010a@bsd.tnes.nec.co.jp>
References: <000001c611df$5556aa00$4168010a@bsd.tnes.nec.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Takashi Sato" <sho@tnes.nec.co.jp> wrote:
>
> Hi,
> 
> I sent following patches three weeks ago, but I got only a few
> responses.
> So, I am sending them again.  Comments are always welcome.

Please don't send multiple patches under the same Subject:.  Please try to
choose nice names for each email, as per
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt, thanks.

> We made patches to fix problems that occur when handling a large
> filesystem and a large file.  It was discussed on the mails titled
> "stat64 for over 2TB file returned invalid st_blocks".

It's best to not refer to an email thread in this manner - the covering
description for a patch should be a self-contained standalone thing which
contains all necessary info to understand the patch.

Could you remind us what problems this patch series solves?  It _appears_
to solve statfs reporting.  Does it fix anything else?  There have been a
couple of reports of filesystems outright failing on >2TB devices - does it
address those problems, if so how?

> The content of the patch attached to this mail is below.
> - inode.i_blocks
>     Change the type from unsigned long to sector_t.
> - kstat.blocks
>     Change the type from unsigned long to unsigned long long.
> - stat64.st_blocks
>     Change the type from unsigned long to unsigned long long on
>     architectures (i386, m68k, sh).

Seems reasonable.

