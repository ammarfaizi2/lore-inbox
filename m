Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317541AbSFKVCY>; Tue, 11 Jun 2002 17:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317543AbSFKVCX>; Tue, 11 Jun 2002 17:02:23 -0400
Received: from ns.suse.de ([213.95.15.193]:4874 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317541AbSFKVCW>;
	Tue, 11 Jun 2002 17:02:22 -0400
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Multicast netlink for non-root process
In-Reply-To: <20020611134418.A22893@bougret.hpl.hp.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 11 Jun 2002 23:02:22 +0200
Message-ID: <p737kl5cyw1.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes <jt@bougret.hpl.hp.com> writes:
> 	The cause is here :
> ----------- net/netlink/af_netlink.c - l322 ------------------
> 
> static int netlink_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
> {
> [...]
> 	/* Only superuser is allowed to listen multicasts */
> 	if (nladdr->nl_groups && !capable(CAP_NET_ADMIN))
> 		return -EPERM;
> --------------------------------------------------------------
> 
> 	Why ?

There used to be a reason for it (ask Alexey for details), but it has gone.
It should be safe now to remove it I think.

-Andi

