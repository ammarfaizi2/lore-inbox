Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWHPXax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWHPXax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWHPXax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:30:53 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:20929 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750959AbWHPXaw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:30:52 -0400
Date: Wed, 16 Aug 2006 18:30:28 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, akpm@osdl.org, jeff@garzik.org,
       netdev@vger.kernel.org, jklewis@us.ibm.com,
       linux-kernel@vger.kernel.org, Jens.Osterkamp@de.ibm.com,
       David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
Message-ID: <20060816233028.GO20551@austin.ibm.com>
References: <44E38157.4070805@garzik.org> <200608162324.47235.arnd@arndb.de> <20060816.143203.11626235.davem@davemloft.net> <200608170016.47072.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200608170016.47072.arnd@arndb.de>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 12:16:46AM +0200, Arnd Bergmann wrote:
> Am Wednesday 16 August 2006 23:32 schrieb David Miller:
> > Can spidernet be told these kinds of parameters?  "N packets or
> > X usecs"?
> 
> It can not do exactly this but probably we can get close to it by

Why would you want o do this? It seems like a cruddier strategy 
than what we can already do  (which is to never get an transmit
interrupt, as long as the kernel can shove data into the device fast
enough to keep the queue from going empty.)  The whole *point* of a 
low-watermark interrupt is to never have to actually get the interrupt, 
if the rest of the system is on its toes and is supplying data fast
enough.

--linas

