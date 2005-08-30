Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVH3E7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVH3E7D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVH3E7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:59:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:46294 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932141AbVH3E7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:59:00 -0400
Subject: Re: Ignore disabled ROM resources at setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       greg@kroah.com, helgehaf@aitel.hist.no
In-Reply-To: <9e473391050829215148807c49@mail.gmail.com>
References: <1125371996.11963.37.camel@gaston>
	 <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>
	 <Pine.LNX.4.58.0508292056530.3243@g5.osdl.org>
	 <20050829.212021.43291105.davem@davemloft.net>
	 <Pine.LNX.4.58.0508292125571.3243@g5.osdl.org>
	 <9e473391050829215148807c49@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 30 Aug 2005 14:54:12 +1000
Message-Id: <1125377653.11963.57.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I was reading the status out of the PCI config space to account for
> our friend X which enables ROMs without informing the OS. With X
> around PCI config space can get out of sync with the kernel
> structures.

Well, X isn't supposed to keep the ROM enabled is it ? besides, most of
the time, the kernel code will be run at boot. I think we shouldn't care
here. If X does the wrong thing, it will eventually break but it
shouldn't break in the "normal" case and it will ultimately be fixed
(finger crossed) by R7.1

Ben.
 


