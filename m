Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUIIOLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUIIOLZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 10:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUIIOLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 10:11:24 -0400
Received: from the-village.bc.nu ([81.2.110.252]:30122 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264396AbUIIOJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 10:09:59 -0400
Subject: Re: multi-domain PCI and sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, jbarnes@engr.sgi.com,
       willy@debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9e473391040908173179bf4647@mail.gmail.com>
References: <9e4733910409041300139dabe0@mail.gmail.com>
	 <200409072115.09856.jbarnes@engr.sgi.com>
	 <20040907211637.20de06f4.davem@davemloft.net>
	 <200409072125.41153.jbarnes@engr.sgi.com>
	 <9e47339104090723554eb021e4@mail.gmail.com>
	 <20040908112143.330a9301.davem@davemloft.net>
	 <1094683264.12335.35.camel@localhost.localdomain>
	 <9e473391040908173179bf4647@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094735187.14657.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 14:06:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-09 at 01:31, Jon Smirl wrote:
> I think the problem is more basic than building a VGA device. I
> wouldn't be having trouble if there were structures for each "PCI IO
> space". An x86 machine would have one of these structs. Other

Depends which x86. 

The single trivial arch function I proposed in the previous mail is
enough to untangle this problem and has two virtues

1. For most platforms the implementation is "return 1"
2. The minimal implementation is merely less efficient so you don't
have to hack every conceivable case at once.

> architectures would have multiple ones. You need these structs to find
> any PCI legacy device, the problem is not specific to VGA.

There are essentially no other devices we care about. IDE legacy is
dealt with BIOS level and never touched again - so why bother designing
for them.

