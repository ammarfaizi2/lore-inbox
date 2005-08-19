Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbVHSPJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbVHSPJt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 11:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbVHSPJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 11:09:49 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:5371 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S964961AbVHSPJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 11:09:48 -0400
Date: Fri, 19 Aug 2005 08:09:21 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: David Teigland <teigland@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, mark.fasheh@oracle.com
Subject: Re: [PATCH] configfs: export config_group_find_obj
Message-ID: <20050819150921.GB18991@ca-server1.us.oracle.com>
Mail-Followup-To: David Teigland <teigland@redhat.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, mark.fasheh@oracle.com
References: <20050818062602.GD10133@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050818062602.GD10133@redhat.com>
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 02:26:02PM +0800, David Teigland wrote:
> In the dlm I use config_group_find_obj() which isn't exported.

	Did you notice the /* XXX Locking */?  Let me go see how you use
it, if it is the best way, we'll need to revisit the function and be
sure it's happy.

Joel

> 
> Signed-off-by: David Teigland <teigland@redhat.com>
> 
> diff -urpN a/fs/configfs/item.c b/fs/configfs/item.c
> --- a/fs/configfs/item.c	2005-08-17 17:19:23.000000000 +0800
> +++ b/fs/configfs/item.c	2005-08-18 14:15:51.681973168 +0800
> @@ -224,4 +224,5 @@ EXPORT_SYMBOL(config_item_init);
>  EXPORT_SYMBOL(config_group_init);
>  EXPORT_SYMBOL(config_item_get);
>  EXPORT_SYMBOL(config_item_put);
> +EXPORT_SYMBOL(config_group_find_obj);
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

"Time is an illusion, lunchtime doubly so."
        -Douglas Adams

			http://www.jlbec.org/
			jlbec@evilplan.org

