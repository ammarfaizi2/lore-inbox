Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVBGX4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVBGX4O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 18:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVBGX4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 18:56:14 -0500
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:17426 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id S261343AbVBGX4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 18:56:09 -0500
Message-ID: <420801D7.3020405@gentoo.org>
Date: Tue, 08 Feb 2005 00:03:35 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3: Kylix application no longer works?
References: <20050207221107.GA1369@elf.ucw.cz> <20050207145100.6208b8b9.akpm@osdl.org>
In-Reply-To: <20050207145100.6208b8b9.akpm@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CyIjg-0009kc-S3*cx5g5DXr.hk*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I wonder if reverting the patch will restore the old behaviour?
> 
> # This is a BitKeeper generated diff -Nru style patch.
> #
> # ChangeSet
> #   2005/01/21 13:42:18-08:00 davem@nuts.davemloft.net 
> #   Merge nuts.davemloft.net:/disk1/BK/sparcwork-2.6
> #   into nuts.davemloft.net:/disk1/BK/sparc-2.6
> # 
> # fs/binfmt_elf.c
> #   2005/01/21 13:42:06-08:00 davem@nuts.davemloft.net +0 -0
> #   Auto merged
> # 
> # ChangeSet
> #   2005/01/17 13:38:38-08:00 ecd@skynet.be 
> #   [SPARC64]: Missing user access return value checks in fs/binfmt_elf.c and fs/compat.c
> #   
> #   Signed-off-by: David S. Miller <davem@davemloft.net>
> # 
> # fs/compat_ioctl.c
> #   2005/01/17 13:37:56-08:00 ecd@skynet.be +12 -5
> #   [SPARC64]: Missing user access return value checks in fs/binfmt_elf.c and fs/compat.c
> # 
> # fs/binfmt_elf.c
> #   2005/01/17 13:37:56-08:00 ecd@skynet.be +43 -19
> #   [SPARC64]: Missing user access return value checks in fs/binfmt_elf.c and fs/compat.c
> # 

I think so. For a short period we applied this patch to the Gentoo 2.6.10 
kernel...

http://dev.gentoo.org/~dsd/gentoo-dev-sources/release-10.01/dist/1900_umem_catch.patch

...but removed it once users complained it stopped kylix binaries from running.

Daniel
