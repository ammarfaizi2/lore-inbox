Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268694AbUH3Rfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268694AbUH3Rfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268646AbUH3Rfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:35:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30906 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268650AbUH3RdN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:33:13 -0400
Message-ID: <413364CC.8090901@pobox.com>
Date: Mon, 30 Aug 2004 13:33:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: Peter Holik <peter@holik.at>, linux-kernel@vger.kernel.org,
       Francois Romieu <romieu@fr.zoreil.com>, netdev@oss.sgi.com
Subject: Re: PROBLEM: fix fealnx.c hangs on SMP, 2.4.27
References: <38386.192.168.1.2.1093850895.squirrel@www.it-technology.at> <200408301157.03334.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408301157.03334.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Monday 30 August 2004 10:28, Peter Holik wrote:
> 
>>static void set_rx_mode(struct net_device *dev)
>>{
>>   spinlock_t *lp = &((struct netdev_private *)dev->priv)->lock;
>>   unsigned long flags;
>>   spin_lock_irqsave(lp, flags);
>>   __set_rx_mode(dev);
>>-  spin_unlock_irqrestore(&lp, flags);
>>+  spin_unlock_irqrestore(lp, flags);
>>}
> 
> 
> Oh... it was my change which was buggy... Thanks for the fix!
> 
> Jeff, 2.6 most probably has the same bug.


Upstream 2.6 already has the fix...

	Jeff


