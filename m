Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136917AbRASWCs>; Fri, 19 Jan 2001 17:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136899AbRASWCi>; Fri, 19 Jan 2001 17:02:38 -0500
Received: from [129.94.172.186] ([129.94.172.186]:37115 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S136896AbRASWC3>;
	Fri, 19 Jan 2001 17:02:29 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: rtviado <root@iligan.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ip_conntrack: maximum limit of 16368 entries exceeded 
In-Reply-To: Your message of "Tue, 16 Jan 2001 14:48:40 +0800."
             <Pine.LNX.4.30.0101161444450.24215-100000@bigbird-ipgi.iligan.com> 
Date: Wed, 17 Jan 2001 13:13:28 +1100
Message-Id: <E14Ii6K-00014V-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.30.0101161444450.24215-100000@bigbird-ipgi.iligan.com> y
ou write:
> I got this in my logs:
> 
>  ip_conntrack: maximum limit of 16368 entries exceeded

It's  OK, it  just means  that you  have *alot*  of  connections going
through your box (or maybe you don't route both ways through your box,
which you need to do for  connection tracking to work).  We have to be
slow in  timing out connections, but  when the limit gets  hit, we get
more aggressive: the algo's pretty  good, so you probably won't notice
any problems.

Cheers,
Rusty.
--
http://linux.conf.au The Linux conference Australia needed.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
