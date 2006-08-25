Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422735AbWHYWz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422735AbWHYWz6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 18:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWHYWz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 18:55:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23723
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964771AbWHYWz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 18:55:57 -0400
Date: Fri, 25 Aug 2006 15:56:02 -0700 (PDT)
Message-Id: <20060825.155602.132757635.davem@davemloft.net>
To: shemminger@osdl.org
Cc: sithglan@stud.uni-erlangen.de, herbert@gondor.apana.org.au,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPV6 : segmentation offload not set correctly on TCP
 children
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060825154353.3ecaf508@localhost.localdomain>
References: <20060821150231.31a947d4@localhost.localdomain>
	<20060821222634.GC21790@cip.informatik.uni-erlangen.de>
	<20060825154353.3ecaf508@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Fri, 25 Aug 2006 15:43:53 -0700

> TCP over IPV6 would incorrectly inherit the GSO settings.
> This would cause kernel to send Tcp Segmentation Offload packets for
> IPV6 data to devices that can't handle it. It caused the sky2 driver
> to lock http://bugzilla.kernel.org/show_bug.cgi?id=7050
> and the e1000 would generate bogus packets. I can't blame the
> hardware for gagging if the upper layers feed it garbage.
> 
> This was a new bug in 2.6.18 introduced with GSO support.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

Good catch.  Applied, thanks Stephen.
