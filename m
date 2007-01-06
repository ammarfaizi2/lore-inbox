Return-Path: <linux-kernel-owner+w=401wt.eu-S1751425AbXAFQSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbXAFQSS (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 11:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbXAFQSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 11:18:17 -0500
Received: from styx.suse.cz ([82.119.242.94]:46346 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751425AbXAFQSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 11:18:17 -0500
Date: Sat, 6 Jan 2007 17:18:09 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] HID-Core: Tiny patch to remove a kmalloc cast
In-Reply-To: <20070106131852.GF19020@Ahmed>
Message-ID: <Pine.LNX.4.64.0701061715300.3771@jikos.suse.cz>
References: <20070106131852.GF19020@Ahmed>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2007, Ahmed S. Darwish wrote:

> Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 18c2b3c..2fcfdbb 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -656,7 +656,7 @@ struct hid_device *hid_parse_report(__u8 *start, unsigned size)
>  	for (i = 0; i < HID_REPORT_TYPES; i++)
>  		INIT_LIST_HEAD(&device->report_enum[i].report_list);
>  
> -	if (!(device->rdesc = (__u8 *)kmalloc(size, GFP_KERNEL))) {
> +	if (!(device->rdesc = kmalloc(size, GFP_KERNEL))) {
>  		kfree(device->collection);
>  		kfree(device);
>  		return NULL;

Queued for upstream, thanks.

-- 
Jiri Kosina
SUSE Labs
