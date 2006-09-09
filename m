Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWIIKIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWIIKIW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 06:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWIIKIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 06:08:22 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52708
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750921AbWIIKIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 06:08:21 -0400
Date: Sat, 09 Sep 2006 03:08:54 -0700 (PDT)
Message-Id: <20060909.030854.78720744.davem@davemloft.net>
To: jeff@garzik.org
Cc: paulus@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, akpm@osdl.org, segher@kernel.crashing.org
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: David Miller <davem@davemloft.net>
In-Reply-To: <45028F87.7040603@garzik.org>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
	<20060909.023405.71099525.davem@davemloft.net>
	<45028F87.7040603@garzik.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jeff@garzik.org>
Date: Sat, 09 Sep 2006 05:55:19 -0400

> As (I think) BenH mentioned in another email, the normal way Linux 
> handles these interfaces is for the primary API (readX, writeX) to be 
> strongly ordered, strongly coherent, etc.  And then there is a relaxed 
> version without barriers and syncs, for the smart guys who know what 
> they're doing

Indeed, I think that is the way to handle this.
