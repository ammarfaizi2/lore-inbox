Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUFCUBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUFCUBz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 16:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264205AbUFCUBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 16:01:54 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:65258 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S263736AbUFCUBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 16:01:53 -0400
Message-ID: <40BF83AD.1020401@stanchina.net>
Date: Thu, 03 Jun 2004 22:01:49 +0200
From: Flavio Stanchina <flavio@stanchina.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no
Subject: Re: Linux 2.6.7-rc2
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org>	<m3y8n93qak.fsf@telia.com>	<Pine.LNX.4.58.0405310955420.4573@ppc970.osdl.org> <m34qpw5k4h.fsf@telia.com>
In-Reply-To: <m34qpw5k4h.fsf@telia.com>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:
> [patch to linux/fs/nfs/read.c]
> +	memset(rdata, 0, sizeof(*rdata));
> +	rdata->flags = (IS_SWAPFILE(inode)? NFS_RPC_SWAPFLAGS : 0);

Wouldn't this be better as:
   if (IS_SWAPFILE(inode))
     rdata->flags = NFS_RPC_SWAPFLAGS;

> +	rdata->args.pgbase = 0UL;

Wouldn't this be redundant?

-- 
Ciao, Flavio

