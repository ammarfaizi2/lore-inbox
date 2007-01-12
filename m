Return-Path: <linux-kernel-owner+w=401wt.eu-S1161019AbXALHf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbXALHf4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 02:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbXALHf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 02:35:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:19597 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161019AbXALHfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 02:35:55 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=FYHH8tFhJDk2aaIb819EBMB7TPueDWjC/LOzgPnHRMHRE+tyaR7JOzOv31Joa13KSvirE+KPtyHeY/rTCQ4iZ7c2us0X+eTHM1Rg2ZyY21sKnd7wy+g1VKI1jkYsIlR8f4R0tR18b3ad8TpaHqcCSHHWP/DrTHfrkdPcucwtg/E=
Message-ID: <84144f020701112335v44bcf8a5see13fdbf01b700cd@mail.gmail.com>
Date: Fri, 12 Jan 2007 09:35:52 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "joe jin" <joe.jin@oracle.com>
Subject: Re: [PATCH] bonding: Replace kmalloc() + memset() pairs with the appropriate kzalloc() calls
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <1168568903.10377.7.camel@joejin-pc.cn.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1168568903.10377.7.camel@joejin-pc.cn.oracle.com>
X-Google-Sender-Auth: d9233be372b1572a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 1/12/07, joe jin <joe.jin@oracle.com> wrote:
> @@ -788,7 +786,7 @@ static int rlb_initialize(struct bonding
>
>         spin_lock_init(&(bond_info->rx_hashtbl_lock));
>
> -       new_hashtbl = kmalloc(size, GFP_KERNEL);
> +       new_hashtbl = kzalloc(size, GFP_KERNEL);
>         if (!new_hashtbl) {
>                 printk(KERN_ERR DRV_NAME
>                        ": %s: Error: Failed to allocate RLB hash table\n",

You forgot to remove the memset here.
