Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWBHE6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWBHE6s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 23:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWBHE6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 23:58:48 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:50647 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1030338AbWBHE6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 23:58:47 -0500
Message-ID: <43E97A74.8000006@cs.wisc.edu>
Date: Tue, 07 Feb 2006 22:58:28 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 20/29] scsi_transport_iscsi gfp_t annotations
References: <E1F6frg-0006DY-4T@ZenIV.linux.org.uk>
In-Reply-To: <E1F6frg-0006DY-4T@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> Date: 1138793445 -0500
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> ---
> 
>  drivers/scsi/scsi_transport_iscsi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> e5fb81bd895041230dfaeb8f8f498b85b4705988
> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
> index 59a1c9d..723f7ac 100644
> --- a/drivers/scsi/scsi_transport_iscsi.c
> +++ b/drivers/scsi/scsi_transport_iscsi.c
> @@ -463,7 +463,7 @@ static inline struct list_head *skb_to_l
>  }
>  
>  static void*
> -mempool_zone_alloc_skb(unsigned int gfp_mask, void *pool_data)
> +mempool_zone_alloc_skb(gfp_t gfp_mask, void *pool_data)
>  {
>  	struct mempool_zone *zone = pool_data;
>  

Thanks. I also sent a patch to do this a couple days ago. It is in one 
of James's trees here:

http://kernel.org/git/?p=linux/kernel/git/jejb/scsi-rc-fixes-2.6.git;a=commit;h=28e5554df63085be3b8bd2aee6ddbc479f0d136e
