Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262810AbSJJWNR>; Thu, 10 Oct 2002 18:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262815AbSJJWNR>; Thu, 10 Oct 2002 18:13:17 -0400
Received: from ns.suse.de ([213.95.15.193]:23052 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262810AbSJJWNQ>;
	Thu, 10 Oct 2002 18:13:16 -0400
Date: Fri, 11 Oct 2002 00:19:01 +0200
From: Andi Kleen <ak@suse.de>
To: Mark Peloquin <peloquin@us.ibm.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EVMS core (3/9) discover.c
Message-ID: <20021011001901.A16277@wotan.suse.de>
References: <OFDCDB46A2.2BDBA992-ON85256C4E.00748716@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFDCDB46A2.2BDBA992-ON85256C4E.00748716@pok.ibm.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We plan to register a "__this_module.can_unload()" that
> should prevent plugin modules from unloading during
> discovery.

Ok in this case. But how about when you search that list later after
discovery for some reason and drop the lock. Then you could race with someone
else removing the plugin inbetween, no ? 

-Andi
