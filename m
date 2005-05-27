Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVE0CRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVE0CRA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 22:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVE0CQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 22:16:59 -0400
Received: from mail.dvmed.net ([216.237.124.58]:26588 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261439AbVE0CQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 22:16:55 -0400
Message-ID: <42968312.90901@pobox.com>
Date: Thu, 26 May 2005 22:16:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: Grant Grundler <grundler@parisc-linux.org>, akpm@osdl.org,
       T-Bone@parisc-linux.org, varenet@parisc-linux.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: patch tulip-natsemi-dp83840a-phy-fix.patch added to -mm tree
References: <200505101955.j4AJtX9x032464@shell0.pdx.osdl.net> <42881C58.40001@pobox.com> <20050516050843.GA20107@colo.lackof.org> <4288CE51.1050703@pobox.com> <20050521223959.GA4337@electric-eye.fr.zoreil.com>
In-Reply-To: <20050521223959.GA4337@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Jeff Garzik <jgarzik@pobox.com> :
> [tulip_media_select]
> 
>>1) called from timer context, from the media poll timer
>>
>>2) called from spin_lock_irqsave() context, in the ->tx_timeout hook.
>>
>>The first case can be fixed by moved all the timer code to a workqueue. 
>> Then when the existing timer fires, kick the workqueue.
>>
>>The second case can be fixed by kicking the workqueue upon tx_timeout 
>>(which is the reason why I did not suggest queue_delayed_work() use).
> 
> 
> First try below. It only moves tulip_select_media() to process context.
> The original patch (with s/udelay/msleep/ or such) is not included.
> 
> Patch applies/compiles against 2.6.12-rc4.

Looks pretty good to me, at first look.

I'll give it some thought, and probably apply it, in a few days.

	Jeff



