Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWGBNGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWGBNGu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 09:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWGBNGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 09:06:49 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:20192 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751274AbWGBNGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 09:06:48 -0400
Message-ID: <44A7C4E5.6020202@free.fr>
Date: Sun, 02 Jul 2006 15:06:45 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060620 Debian/1.7.13-0.2
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: albertl@mail.com
CC: Jeff Garzik <jeff@garzik.org>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net> <449DBE88.5020809@garzik.org> <449DBFFD.2010700@garzik.org> <449E5445.60008@free.fr> <44A4CE21.30009@tw.ibm.com> <1151654134.44a4d8f6dc320@imp5-g19.free.fr> <44A4E01D.8020604@tw.ibm.com> <44A78599.9060405@free.fr> <44A7A0C8.80108@free.fr> <44A7C00A.7040001@tw.ibm.com>
In-Reply-To: <44A7C00A.7040001@tw.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Albert Lee wrote:
> Hi Matthieu,
> 
> Thanks for the log. But could you please keep the 
> VPRINTK() in the entrance of ata_host_intr()
If I do that, everything works correctly : the printk should take more 
than 3 us, and the altsatus is not busy when we read it.
Here is the log without moving the printk : 
http://castet.matthieu.free.fr/tmp/ata_log.orig

The only thing I could do is to move the printk between altstatus and 
status check and add one in idle_irq.

Will it be usefull for you ?


Matthieu.

