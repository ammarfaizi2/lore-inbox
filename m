Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVDBGov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVDBGov (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 01:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVDBGov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 01:44:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:16796 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261169AbVDBGot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 01:44:49 -0500
Date: Fri, 1 Apr 2005 22:44:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: initramfs linus tree breakage in last day
Message-Id: <20050401224431.6c06ca1e.akpm@osdl.org>
In-Reply-To: <9e47339105040122225b96c774@mail.gmail.com>
References: <9e473391050401181824d9e50f@mail.gmail.com>
	<9e47339105040119302e6bb405@mail.gmail.com>
	<9e47339105040122225b96c774@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl <jonsmirl@gmail.com> wrote:
>
> This will let me boot again. It is not obvious to me where the problem
>  is, it may have something to do with netlink or maybe memory
>  corruption?
> 
>  bk export -tpatch -r1.2326,1.2327 >../foo.patch
>  patch -p1 -R <../foo.patch
> 
>  # ChangeSet
>  #   2005/03/31 21:14:28-08:00 davem@sunset.davemloft.net
>  #   Merge bk://kernel.bkbits.net/acme/net-2.6
>  #   into sunset.davemloft.net:/home/davem/src/BK/net-2.6
>  #
>  # ChangeSet
>  #   2005/03/26 20:04:49-03:00 acme@toy.ghostprotocols.net
>  #   [NET] make all protos partially use sk_prot

Cute.  I assume you have all the memory debug options enabled?

You could try disabling net features in .config, see if you can work out
which one causes it.

