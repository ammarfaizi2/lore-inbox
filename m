Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268919AbUH3UEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268919AbUH3UEO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 16:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268886AbUH3UCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 16:02:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:34776 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268954AbUH3T7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:59:42 -0400
Date: Mon, 30 Aug 2004 12:57:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1 kjournald: page allocation failure. order:1,
 mode:0x20
Message-Id: <20040830125742.18c38277.akpm@osdl.org>
In-Reply-To: <1093873432.1786.16.camel@rakieeta>
References: <1093794970.1751.10.camel@rakieeta>
	<20040829160257.3b881fef.akpm@osdl.org>
	<1093873432.1786.16.camel@rakieeta>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl> wrote:
>
> > There should have been a stack trace as well.  Please send it.
>  > 
> 
>  this time there is an attachement.

OK.  It's netfilter.  Trying to allocate two physically contiguous
pages with GFP_ATOMIC.  This is expected to fail, and networking will
recover OK.

The networking guys are cooking up a fix for this, I believe.
