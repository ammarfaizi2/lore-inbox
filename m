Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUBNMxR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 07:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUBNMxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 07:53:17 -0500
Received: from mlf.linux.rulez.org ([192.188.244.13]:48399 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S261885AbUBNMw6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 07:52:58 -0500
Date: Sat, 14 Feb 2004 13:47:29 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ntfs-dev@lists.sourceforge.net,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [Linux-NTFS-Dev] [2.4] off-by-one kmalloc in ntfs
In-Reply-To: <20040213225621.GA16550@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.21.0402141308460.20885-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 14 Feb 2004, Herbert Xu wrote:

> This patch fixes an off-by-one kmalloc bug in ntfs in 2.4.24.

Thanks for your time fixing bugs in the legacy driver.

May I be interested in your motivations? Recently there is a clear flow of
RedHat refugees to Debian and if you would like better NTFS support then
perhaps Debian should use the backport of the rewritten NTFS driver too,
just like all other distros do who care about NTFS support.

You can find some of the differences between the legacy (in vanilla 2.4)
and the Linux-NTFS project's NTFS driver (it's in in 2.6 and there is
a backport maintained for 2.4):

	http://linux-ntfs.sourceforge.net/status.html

Besides the several drawbacks vanila 2.4 driver has, I'm aware of only two
features it's capable but not the rewritten one:

   - NTFS can be exported via NFS. This came without any work but it would 
     need some time to support with the new driver. There was one request
     for this feature in the last two years so it's not the highest priority
   
   - one can trash his/her NTFS or the box (the legacy diver is not SMP,
     reentrant safe). AFAIK, no plan to add this feature to the new driver 
     neither in the short nor in long term.

  Szaka

