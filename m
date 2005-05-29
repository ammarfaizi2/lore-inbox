Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVE2Vz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVE2Vz6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 17:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVE2Vz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 17:55:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8322
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261456AbVE2Vzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 17:55:54 -0400
Date: Sun, 29 May 2005 14:55:09 -0700 (PDT)
Message-Id: <20050529.145509.82051753.davem@davemloft.net>
To: phdm@macqel.be
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: PATCH : ppp + big-endian = kernel crash
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200505292138.j4TLcrJ28536@mail.macqel.be>
References: <20050529.135257.98862077.davem@davemloft.net>
	<200505292138.j4TLcrJ28536@mail.macqel.be>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Philippe De Muyter" <phdm@macqel.be>
Date: Sun, 29 May 2005 23:38:53 +0200 (CEST)

> Do you mean that ip_rcv may not assume that packets are properly aligned ?
> 
> And some non-mmu m68k (Coldfires) do not provide enough information in
> exception frames to restart instructions on an address error in the general
> case.

So many variants of tunneling and protocol encapsulation can result in
unaligned packet headers, and as a result platforms really must
provide proper unaligned memory access handling in kernel mode in
order to use the networking fully.

All these patches to PPP and friends are merely papering over the
larger problem.
