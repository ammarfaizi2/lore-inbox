Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVH3Fcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVH3Fcm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 01:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVH3Fcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 01:32:42 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50615
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750774AbVH3Fcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 01:32:41 -0400
Date: Mon, 29 Aug 2005 22:32:38 -0700 (PDT)
Message-Id: <20050829.223238.18109086.davem@davemloft.net>
To: jonsmirl@gmail.com
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       helgehaf@aitel.hist.no, torvalds@osdl.org
Subject: Re: Ignore disabled ROM resources at setup
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <9e47339105082921356543098c@mail.gmail.com>
References: <200508261859.j7QIxT0I016917@hera.kernel.org>
	<1125369485.11949.27.camel@gaston>
	<9e47339105082921356543098c@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Smirl <jonsmirl@gmail.com>
Date: Tue, 30 Aug 2005 00:35:11 -0400

> As far as I can tell no one has built recent hardware this way. But I
> believe there are some old SCSI controllers that do this. I provided a
> ROM API for disabling sysfs access, if we identify one of these cards
> we should just add a call to it's driver to disable ROM access instead
> of bothering with the copy. Currently the copy is not being used
> anywhere in the kernel.

Qlogic ISP is one such card, but there are several others.

I think enabling the ROM is a very bad idea, since we in fact
know it disables the I/O and MEM space decoders on a non-empty
set of PCI cards.
