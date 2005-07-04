Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVGDHZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVGDHZw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 03:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVGDHWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 03:22:30 -0400
Received: from main.gmane.org ([80.91.229.2]:51132 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261537AbVGDHTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 03:19:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Stefan Seyfried <seife@suse.de>
Subject: Re: [patch] swsusp: fix error handling
Date: Mon, 04 Jul 2005 08:37:35 +0200
Message-ID: <42C8D92F.5000501@suse.de>
References: <20050703215651.GA10766@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: charybdis-ext.suse.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
In-Reply-To: <20050703215651.GA10766@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> --- a/kernel/power/swsusp.c
> +++ b/kernel/power/swsusp.c

> @@ -998,14 +991,20 @@ int swsusp_suspend(void)
>  	 * at resume time, and evil weirdness ensues.
>  	 */
>  	if ((error = device_power_down(PMSG_FREEZE))) {
> -		printk(KERN_ERR "Some devices failed to power down, aborting suspend\n");

i don't like this one. Silent failures are a major PITA.

> +		printk("Error %d suspending\n", error);

therefor i like this one ;-) Maybe with a printk level?
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen

