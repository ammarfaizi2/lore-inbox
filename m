Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVHRJPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVHRJPx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 05:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVHRJPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 05:15:53 -0400
Received: from [81.2.110.250] ([81.2.110.250]:54700 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932132AbVHRJPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 05:15:52 -0400
Subject: Re: [PATCH] mmc: Multi-sector writes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4304380B.5070406@drzeus.cx>
References: <42FF3C05.70606@drzeus.cx>
	 <20050817155641.12bb20fc.akpm@osdl.org> <43042114.7010503@drzeus.cx>
	 <20050817224805.17f29cfb.akpm@osdl.org>
	 <20050818073824.C2365@flint.arm.linux.org.uk>  <4304380B.5070406@drzeus.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Aug 2005 10:42:48 +0100
Message-Id: <1124358169.13511.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-08-18 at 09:26 +0200, Pierre Ossman wrote:
> everything out first and then fall back on sector-by-sector to determine
> where an error occurs. This will only break if the problematic sector
> keeps shifting around, but at that point the card is probably toast
> anyway (if the thing keeps moving how can you bad block it?).

Providing the sectors are not finally completed to higher levels until
they are written that works fine. I don't think it matters if the bad
sector goes away either. Providing it has gone away and the real data is
on the media we don't care where the underlying bad block went in the
process and who remapped it.

Alan

