Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753822AbWKGW6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbWKGW6L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753828AbWKGW6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:58:10 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48874
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1753822AbWKGW6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:58:09 -0500
Date: Tue, 07 Nov 2006 14:58:09 -0800 (PST)
Message-Id: <20061107.145809.132301902.davem@davemloft.net>
To: mchan@broadcom.com
Cc: bunk@stusta.de, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: tg3_read_partno(): possible array overrun
From: David Miller <davem@davemloft.net>
In-Reply-To: <1162843651.3409.5.camel@rh4>
References: <20061106094527.GG5778@stusta.de>
	<1162843651.3409.5.camel@rh4>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael Chan" <mchan@broadcom.com>
Date: Mon, 06 Nov 2006 12:07:31 -0800

> On Mon, 2006-11-06 at 10:45 +0100, Adrian Bunk wrote:
> > The Coverity checker noted the following in drivers/net/tg3.c:
> > 
> > <--  snip  -->
> > 
> > The problem is that vpd_data[i + 2] could be vpd_data[255 + 2].
> 
> Thanks.  This should fix it:
> 
> [TG3]: Fix array overrun in tg3_read_partno().
> 
> Use proper upper limits for the loops and check for all error
> conditions.
> 
> The problem was noticed by Adrian Bunk.
> 
> Signed-off-by: Michael Chan <mchan@broadcom.com> 

Applied, thanks Michael.
