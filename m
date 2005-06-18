Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVFRWMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVFRWMa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 18:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVFRWMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 18:12:30 -0400
Received: from [195.55.102.196] ([195.55.102.196]:59047 "EHLO
	mx.aytolacoruna.es") by vger.kernel.org with ESMTP id S262171AbVFRWMU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 18:12:20 -0400
Date: Sun, 19 Jun 2005 00:12:16 +0200
From: Santiago Garcia Mantinan <netfilter-devel@manty.net>
To: Chris Rankin <rankincj@yahoo.com>, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12: connection tracking broken?
Message-ID: <20050618221216.GB3182@pul.manty.net>
References: <20050618124359.39052.qmail@web52901.mail.yahoo.com> <20050618192541.GA27439@pul.manty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050618192541.GA27439@pul.manty.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have sent this right now to the bridge list, I'm copying it here so that
> more info is available about this bug.

I have selected patches from 2.6.12 that I thought could be related to this
issue, and I have finaly identified this patch...

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=b31e5b1bb53b99dfd5e890aa07e943aff114ae1c

as the patch causing the problem, I have reversed it on my kernel tree and
now the firewall is working again.

I have not really looked at what the patch does and how it does that, I have
just identified it as the one causing the break of this connection tracking
relating to the bridges.

It seems this is affecting more stuff than the connection tracking on
bridges, I have a friend also suffering problems relating to the firewall in
2.6.12 and nothing to do with the bridge, but he is not around now so I
cannot confirm it is due to this patch also. His problem may be something
related to loopback. I'll try to contact him tomorrow and tell him to test
with this patch reversed.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
