Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992802AbWJUCq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992802AbWJUCq1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 22:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992800AbWJUCq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 22:46:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:43488
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S2992796AbWJUCqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 22:46:25 -0400
Date: Fri, 20 Oct 2006 19:46:27 -0700 (PDT)
Message-Id: <20061020.194627.35015734.davem@davemloft.net>
To: torvalds@osdl.org
Cc: ralf@linux-mips.org, nickpiggin@yahoo.com.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp,
       linux-arch@vger.kernel.org, schwidefsky@de.ibm.com,
       James.Bottomley@SteelEye.com
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0610201934170.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610201733490.3962@g5.osdl.org>
	<20061020.191134.63996591.davem@davemloft.net>
	<Pine.LNX.4.64.0610201934170.3962@g5.osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Fri, 20 Oct 2006 19:37:24 -0700 (PDT)

> On Fri, 20 Oct 2006, David Miller wrote:
> > I think it could help for sun4m highmem configs.
> 
> Well, if you can re-create the performance numbers (Ralf - can you send 
> the full series with the final "remove the now unnecessary flush" to 
> Davem?), that will make deciding things easier, I think.
> 
> I suspect sparc, mips and arm are the main architectures where virtually 
> indexed caching really matters enough for this to be an issue at all.

Unfortunately, I don't have any sparc 32-bit systems any more,
so I can't really help out here.  I just make sure the build
keeps working :-)
