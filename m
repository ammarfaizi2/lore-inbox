Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbWHRXpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWHRXpv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWHRXpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:45:51 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:10903 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751595AbWHRXpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:45:50 -0400
Date: Fri, 18 Aug 2006 18:45:32 -0500
To: David Miller <davem@davemloft.net>
Cc: benh@kernel.crashing.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Jens.Osterkamp@de.ibm.com, jklewis@us.ibm.com, arnd@arndb.de
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
Message-ID: <20060818234532.GA8644@austin.ibm.com>
References: <20060818192356.GD26889@austin.ibm.com> <20060818.142513.29571851.davem@davemloft.net> <20060818224618.GN26889@austin.ibm.com> <20060818.155116.112621100.davem@davemloft.net> <20060818232942.GO26889@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060818232942.GO26889@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 06:29:42PM -0500, linas wrote:
> 
> I don't understand what you are saying. If I call the transmit 
> queue cleanup code from the poll() routine, nothing hapens, 
> because the kernel does not call the poll() routine often 
> enough. I've stated this several times.  

OK, Arnd gave me a clue stick. I need to call the (misnamed)
netif_rx_schedule() from the tx interrupt in order to get 
this to work. That makes sense, and its easy, I'll send the 
revised patch.. well, not tonight, but shortly.

--linas
