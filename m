Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422649AbWHRX3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbWHRX3s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWHRX3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:29:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:22505 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422647AbWHRX3q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:29:46 -0400
Date: Fri, 18 Aug 2006 18:29:42 -0500
To: David Miller <davem@davemloft.net>
Cc: benh@kernel.crashing.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Jens.Osterkamp@de.ibm.com, jklewis@us.ibm.com, arnd@arndb.de
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
Message-ID: <20060818232942.GO26889@austin.ibm.com>
References: <20060818192356.GD26889@austin.ibm.com> <20060818.142513.29571851.davem@davemloft.net> <20060818224618.GN26889@austin.ibm.com> <20060818.155116.112621100.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060818.155116.112621100.davem@davemloft.net>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 03:51:16PM -0700, David Miller wrote:
> I see you moving TX reclaim into tasklets and stuff.  I've vehemently
> against that because you wouldn't need it in order to move TX
> processing into software interrupts if you did it all in NAPI
> ->poll().

I don't understand what you are saying. If I call the transmit 
queue cleanup code from the poll() routine, nothing hapens, 
because the kernel does not call the poll() routine often 
enough. I've stated this several times.  

--linas
