Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTLJBKQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 20:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbTLJBKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 20:10:16 -0500
Received: from vcgwp1.bit-drive.ne.jp ([211.9.32.211]:63911 "HELO
	vcgwp1.bit-drive.ne.jp") by vger.kernel.org with SMTP
	id S262033AbTLJBKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 20:10:02 -0500
From: Akinobu Mita <mita@miraclelinux.com>
To: trond.myklebust@fys.uio.no
Subject: Re: [BUG 2.4] NFS unlocking operation accesses invalid file struct
Date: Wed, 10 Dec 2003 10:06:46 +0900
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200311252000.32094.mita@miraclelinux.com> <200311272054.22316.mita@miraclelinux.com> <16326.9448.320003.775274@charged.uio.no>
In-Reply-To: <16326.9448.320003.775274@charged.uio.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312101006.46157.mita@miraclelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Trond,

I apologize for the delay in responding.

On Friday 28 November 2003 01:23, Trond Myklebust wrote:
> So then the correct thing to do is indeed to wrap the call to
> locks_unlock_delete() with an fget()/fput() pair, and then to remove
> the test for fl_pid in locks_same_owner().
>
> We then need to fix lockd so that it generates correct fl_owners for
> its locks...
>
> Let me see if I can get that right.
>

I looked at your patch carefully
(http://www.fys.uio.no/~trondmy/src/Linux-2.4.x/2.4.23-rc1/linux-2.4.23-01-posix_race.dif)
and I think it would fix the problem completely.

Thanks,

--
Akinobu Mita

