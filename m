Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVL3BAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVL3BAV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 20:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVL3BAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 20:00:21 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:44928 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751185AbVL3BAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 20:00:20 -0500
Date: Fri, 30 Dec 2005 01:59:15 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Dave Airlie <airlied@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: spinlock BUG on b44 netconsole
Message-ID: <20051230005915.GA16587@electric-eye.fr.zoreil.com>
References: <21d7e9970512281915q5f58e32bj456b29af52e2e8fe@mail.gmail.com> <21d7e9970512281915s29cf5ac5p33995791c716fc0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970512281915s29cf5ac5p33995791c716fc0f@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(netdev Cced)

Dave Airlie <airlied@gmail.com> :
[...]

Replace the spinlock in b44_start_xmit by the irq_{save/restore} version.
Do the same around for spin_lock(&np->dev->xmit_lock); in netpoll_send_skb.

If it helps, it's an ugly, buggy, bandaid and you should consider
capturing the messages through a serial cable instead.

If you want to read the details, see the thread "Netconsole violates
dev->hard_start_xmit synch rules" started the 06/09/2005 on
netdev@vger.kernel.org.

--
Ueimor
