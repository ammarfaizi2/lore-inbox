Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVCUWob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVCUWob (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVCUWlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:41:09 -0500
Received: from fire.osdl.org ([65.172.181.4]:45256 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262016AbVCUWhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:37:05 -0500
Date: Mon, 21 Mar 2005 14:36:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Richard Fuchs <richard.fuchs@inode.info>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: slab corruption in skb allocs
Message-Id: <20050321143648.4608a912.akpm@osdl.org>
In-Reply-To: <42283093.7040405@inode.info>
References: <42283093.7040405@inode.info>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Fuchs <richard.fuchs@inode.info> wrote:
>
> he memory allocation debugger gives me the following messages under a
> vanilla 2.6.10 and 2.6.11 kernel when doing
> 
> 1) hdparm -d0 on my hard disk
> 2) tar c / > /dev/null
> 3) sending lots of network traffic to the machine (e.g. close to 100
> mbit/s udp packets)
> 

We ended up deciding that this was a bug in the e100 NAPI implementation.

I have a not-very-official patch in -mm, at
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm1/broken-out/e100-napi-state-machine-fix.patch.
Would you be able to test that?

AFAIK there has been no official fix for this yet.
