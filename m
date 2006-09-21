Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWIUN3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWIUN3c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 09:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWIUN3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 09:29:32 -0400
Received: from mx00.ext.bfk.de ([217.29.46.125]:55529 "EHLO mx00.ext.bfk.de")
	by vger.kernel.org with ESMTP id S1750788AbWIUN3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 09:29:31 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: Hayim Shaul <hayim@iportent.com>, Jeff Garzik <jeff@garzik.org>,
       netdev@vger.kernel.org, edward_peng@dlink.com.tw,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc6 1/2] dllink driver: porting v1.19 to linux 2.6.18-rc6
References: <1157620189.2904.16.camel@localhost.localdomain>
	<1157620795.14882.16.camel@laptopd505.fenrus.org>
From: Florian Weimer <fweimer@bfk.de>
Date: Thu, 21 Sep 2006 15:29:09 +0200
In-Reply-To: <1157620795.14882.16.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "Thu, 07 Sep 2006 11:19:55 +0200")
Message-ID: <82slilmjq2.fsf@mid.bfk.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven:

>>  	if (irq)
>>  		spin_lock(&np->tx_lock);
>>  	else
>>  		spin_lock_irqsave(&np->tx_lock, flag);
>
> double eeeep
>
> this is wrong to do with in_interrupt() as gating factor!

Well, this is not Hayim fault.  It's in 2.6.18 as is.

Unfortunately, the driver does not work very well.  Transmitting
frames hangs after a while (quickly to reproduce with ping -f
-s40000).  Any suggestions how we could this get working?  The cards
used work quite well in older systems despite all the driver bugs, but
current systems with different timings expose them.

-- 
Florian Weimer                <fweimer@bfk.de>
BFK edv-consulting GmbH       http://www.bfk.de/
Durlacher Allee 47            tel: +49-721-96201-1
D-76131 Karlsruhe             fax: +49-721-96201-99
