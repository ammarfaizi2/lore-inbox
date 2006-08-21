Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWHUXwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWHUXwv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 19:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWHUXwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 19:52:51 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:6785 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750749AbWHUXwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 19:52:50 -0400
Date: Mon, 21 Aug 2006 18:52:44 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Hemminger <shemminger@osdl.org>, akpm@osdl.org,
       netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>, David Miller <davem@davemloft.net>
Subject: Re: [RFC] HOWTO use NAPI to reduce TX interrupts
Message-ID: <20060821235244.GJ5427@austin.ibm.com>
References: <20060818220700.GG26889@austin.ibm.com> <200608190256.26373.arnd@arndb.de> <44E7BB7F.7030204@osdl.org> <200608191325.19557.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608191325.19557.arnd@arndb.de>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 01:25:18PM +0200, Arnd Bergmann wrote:
> 
> What is the best way to treat the IRQ mask for TX interrupts?
> I guess it should be roughly:
> 
> - off when we expect ->poll() to be called, i.e. after calling
>   netif_rx_schedule() or returning after a partial rx from poll().

Under what circumstance does one turn TX interrupts back on?
I couldn't quite figure that out.

--linas
