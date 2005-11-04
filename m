Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVKDRrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVKDRrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 12:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVKDRrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 12:47:52 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:15014 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750771AbVKDRru
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 12:47:50 -0500
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
Organization: IBM
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Subject: Re: [PATCH 11/12: eCryptfs] Keystore
Date: Fri, 4 Nov 2005 11:52:00 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
References: <20051103033220.GD2772@sshock.rn.byu.edu> <20051103035611.GK3005@sshock.rn.byu.edu>
In-Reply-To: <20051103035611.GK3005@sshock.rn.byu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511041152.00540.tinytim@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 November 2005 21:56, Phillip Hellewell wrote:
> +static void wipe_auth_tok_list(struct list_head *auth_tok_list_head)
> +{
> +	struct list_head *walker;
> +	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
> +	walker = auth_tok_list_head->next;
> +	while (walker != auth_tok_list_head) {
> +		struct ecryptfs_auth_tok_list_item *auth_tok_list_item;
> +		auth_tok_list_item =
> +		    list_entry(walker, struct ecryptfs_auth_tok_list_item,
> +			       list);
> +		walker = auth_tok_list_item->list.next;
> +		ecryptfs_kmem_cache_free(ecryptfs_auth_tok_list_item_cache,
> +					 auth_tok_list_item);
> +	}

list_for_each_entry_safe ??

-tim
