Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262693AbSI1DdW>; Fri, 27 Sep 2002 23:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262694AbSI1DdW>; Fri, 27 Sep 2002 23:33:22 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:56772 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262693AbSI1DdW>;
	Fri, 27 Sep 2002 23:33:22 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200209280338.HAA02810@sex.inr.ac.ru>
Subject: Re: [PATCH] IPv6: Improvement of Source Address Selection
To: davem@redhat.com (David S. Miller)
Date: Sat, 28 Sep 2002 07:38:09 +0400 (MSD)
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
In-Reply-To: <20020927.195507.87349906.davem@redhat.com> from "David S. Miller" at Sep 27, 2 07:55:07 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> suggest applies both to current code and code after Yoshi's change.

This is wrong, unfortunately. The elimination of ipv6_get_saddr()
was trivial before this patch (because of independance of preferred source
on real destination, only on scope), the corresponding fix was withdrawn
from 2.4 only for sake of this feature, pending as a well-known patch.
Now I see retransmission of practicllay the same patch, which was deferred
for improvement that time.

Citing myself two years younger:

> The first priority task is to eliminate address selection function.
> 
> Without this odd feature it was easy and, in fact, address selection
> patches forced me to withdraw the solution from kernel, because
> it makes these hacks much more difficult.

Alexey
