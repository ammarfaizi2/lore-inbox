Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbUBUPdb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 10:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbUBUPdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 10:33:31 -0500
Received: from main.gmane.org ([80.91.224.249]:48033 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261572AbUBUPd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 10:33:29 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Multiple NIC cards in the same machine and 2.5/2.6
Date: Sat, 21 Feb 2004 18:33:18 +0300
Message-ID: <pan.2004.02.21.15.33.18.150094@altlinux.ru>
References: <200402210815.55770.notellin@speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213.177.124.23
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Feb 2004 08:15:55 -0500, NoTellin wrote:

> alias eth0 ne
> alias eth1 ne
> options eth0 -o ne-0 io=0x300 irq=3
> options eth1 -o ne-1 io=0x200 irq=5
> alias eth2 winbond-840
> alias eth3 3c509
> 
> This works perfectly fine for the 2.4.x series of kernels up to 
> and including 2.4.24
> 
> However, I can't get this to work in any 2.5/2.6 kernel. The 2.6 
> series of kernels will recognize that there are 3 nic cards but 
> doesn't seem to accept 2 copies of the ne nic drivers in memory. 
> I've tested this up to and including 2.6.3.

There is no need to load two copies of the ne module.  Just use:

alias eth0 ne
alias eth1 ne
options ne io=0x300,0x200 irq=3,5


