Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWIZCzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWIZCzp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 22:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWIZCzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 22:55:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:5863 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750732AbWIZCzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 22:55:44 -0400
Subject: Re: [PATCH 2.6.19-rc1] ehea firmware interface based on Anton
	Blanchard's new hvcall interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Jan-Bernd Themann <ossthema@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       pmac@au1.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
In-Reply-To: <45186F25.9000700@garzik.org>
References: <200609251550.01514.ossthema@de.ibm.com>
	 <45186F25.9000700@garzik.org>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 12:53:51 +1000
Message-Id: <1159239231.5462.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-25 at 20:07 -0400, Jeff Garzik wrote:
> patch does not apply.
> 
> also, it would seem like varargs would be appropriate here.

Not really... these are hypervisor calls, their calling convention is
not varargs, thus we would need some conversion layer if using them,
with possible performance loss (it's also hard to do right as we are
passing args by registers, not stack).

Ben.


