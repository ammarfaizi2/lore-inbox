Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWGBOR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWGBOR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 10:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWGBOR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 10:17:28 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:7909 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751085AbWGBOR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 10:17:27 -0400
Message-ID: <44A7D571.8030504@tw.ibm.com>
Date: Sun, 02 Jul 2006 22:17:21 +0800
From: Albert Lee <albertcc@tw.ibm.com>
Reply-To: albertl@mail.com
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: matthieu castet <castet.matthieu@free.fr>
CC: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net> <449DBE88.5020809@garzik.org> <449DBFFD.2010700@garzik.org> <449E5445.60008@free.fr> <44A4CE21.30009@tw.ibm.com> <1151654134.44a4d8f6dc320@imp5-g19.free.fr> <44A4E01D.8020604@tw.ibm.com> <44A78599.9060405@free.fr> <44A7A0C8.80108@free.fr> <44A7C00A.7040001@tw.ibm.com> <44A7C4E5.6020202@free.fr>
In-Reply-To: <44A7C4E5.6020202@free.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthieu castet wrote:
> Hi,
> 
> Albert Lee wrote:
> 
>> Hi Matthieu,
>>
>> Thanks for the log. But could you please keep the VPRINTK() in the
>> entrance of ata_host_intr()
> 
> If I do that, everything works correctly : the printk should take more
> than 3 us, and the altsatus is not busy when we read it.
> Here is the log without moving the printk :
> http://castet.matthieu.free.fr/tmp/ata_log.orig

Hmm, the Uncertainty principle also applies to kernel debugging. :)

> 
> The only thing I could do is to move the printk between altstatus and
> status check and add one in idle_irq.
> 
> Will it be usefull for you ?
> 
> 
> Matthieu.
> 
> 

>From your previous log, the timeout transacation is clearly logged
and it does look like early irq. Can compare/see both timeout and normal
behaviors of libata from both logs. So, the logs are good enough.

Thanks and appreciates for the logs, :)

Albert

