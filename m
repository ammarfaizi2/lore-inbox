Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265920AbUAEVTN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUAEVTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:19:13 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:17901 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S265920AbUAEVTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:19:08 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
Date: Mon, 5 Jan 2004 22:17:07 +0100
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.44.0401041112290.12250-100000@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.44.0401041112290.12250-100000@bigblue.dev.mdolabs.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200401052205.12344.ioe-lkml@rameria.de>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Davide,
hi lkml,

On Sunday 04 January 2004 20:20, you wrote:
> The problem with poll/select is not the Linux implementation. It is the
> API that is flawed when applied to large fd sets. Every call pass to the
> system the whole fd set, and this makes the API O(N) by definition. While
> poll/select are perfectly ok for small fd sets, epoll LT might enable the
> application to migrate from poll/select to epoll pretty quickly (if the
> application architecture is fairly sane). For example, it took about 15
> minutes to me to make an epoll'd thttpd.

Yes, I've read your analysis several years ago already and I'm the first
one lobbying for epoll, but look at the posting stating, that INN sucks
under Linux currently, but doesn't suck that hard under FreeBSD and
Solaris.

There are already enough things you cannot do properly under Linux
(which are mostly not Linux' fault, but still), so I don't want to add
another one. Especially in the server market, where the M$ lobbyists are
growing their market share.


But if there is some minimal funding available (50 EUR?), I would do it
myself and push the patches upstream ;-)


Regards

Ingo Oeser


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/+dRTU56oYWuOrkARAo60AJ9kYn39UEOvf/XR/Jx6aR4yIZWIYwCggPiT
zB84XIY75b3Z05KXS7qewbw=
=+wI/
-----END PGP SIGNATURE-----

