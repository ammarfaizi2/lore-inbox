Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVACWsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVACWsF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVACWNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:13:52 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:6066 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261938AbVACWKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:10:38 -0500
Subject: Re: [XEN] using shmfs for swapspace
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       xen-devel@lists.sourceforge.net
In-Reply-To: <20050103205318.GD6631@lkcl.net>
References: <20050102162652.GA12268@lkcl.net>
	 <20050103183133.GA19081@samarkand.rivenstone.net>
	 <20050103205318.GD6631@lkcl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104785749.13302.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 03 Jan 2005 21:06:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  so this tends to suggest a strategy where you allocate as
>  much memory as you can afford to the DOM0 VM, and as little
>  as you can afford to the guests, and make the guest swap
>  files bigger to compensate.

This is essentially what the mainframe folks are already doing and have
been doing for some time because the kernel VM has no external inputs
for saying "you are virtualised so be nice" 
for doing opportunistic page recycling ("I dont need this page but when
I ask for it back please tell me if you trashed the content") and for
hinting to the underlying VM what pages are best blasted out of
existance first and how to communicate so we dont page them back in
scanning them.


