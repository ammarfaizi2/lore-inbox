Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271492AbTGQPRz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 11:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271491AbTGQPRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 11:17:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29828 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271489AbTGQPRt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 11:17:49 -0400
Message-ID: <3F16C190.3080205@pobox.com>
Date: Thu, 17 Jul 2003 11:32:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: ricardo.b@zmail.pt
CC: linux-kernel@vger.kernel.org
Subject: Re: SET_MODULE_OWNER
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net>
In-Reply-To: <1058446580.18647.11.camel@ezquiel.nara.homeip.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Bugalho wrote:
> Hi all,
>   most net device drivers have replaced MOD_INC/DEC_USE_COUNT with
> SET_MODULE_OWNER but SET_MODULE_OWNER doesn't do nothing.
>   Therefore, those modules (though I can only vouch for 8139too) always
> report 0 use. Some people that had "modprobe -r" in their cronttab found
> it quite annoying.
>   I'd guess that there's a good reason for why struct net_device doesn't
> have .owner field and why this happens. Can someone be so kind to point
> it
> out? 


struct net_device does have an owner field, and SET_MODULE_OWNER 
obviously _does_ do something.

If your interface is up, your net driver's module refcount is greater 
than zero.

	Jeff



