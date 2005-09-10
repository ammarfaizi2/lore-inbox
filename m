Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVIJWCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVIJWCY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVIJWCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:02:24 -0400
Received: from main.gmane.org ([80.91.229.2]:6629 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932268AbVIJWCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:02:23 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: [PATCH 10/10] drivers/char: pci_find_device remove (drivers/char/watchdog/i8xx_tco.c)
Date: Sun, 11 Sep 2005 00:00:42 +0200
Message-ID: <pan.2005.09.10.22.00.37.88931@free.fr>
References: <200509101221.j8ACLAOV017267@localhost.localdomain> <43234909.8040707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, 10 Sep 2005 16:58:49 -0400, Jeff Garzik a écrit :

> Jiri Slaby wrote:
>> diff --git a/drivers/char/watchdog/i8xx_tco.c b/drivers/char/watchdog/i8xx_tco.c
>> --- a/drivers/char/watchdog/i8xx_tco.c
>> +++ b/drivers/char/watchdog/i8xx_tco.c
>> -	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
>> +	for_each_pci_dev(dev)
>>  		if (pci_match_id(i8xx_tco_pci_tbl, dev)) {
>>  			i8xx_tco_pci = dev;
>>  			break;
>>  		}
>> -	}
> 
> 
> Surely there is a better way to handle bridge matching?
> 
That what is already done in drivers/char/hw_random.c ...

