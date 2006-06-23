Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932981AbWFWJ7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932981AbWFWJ7K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932982AbWFWJ7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:59:10 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:61154 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932981AbWFWJ7J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:59:09 -0400
Date: Fri, 23 Jun 2006 11:59:09 +0200
From: Frank Pavlic <fpavlic@de.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux390@de.ibm.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390: move var declarations behind ifdef
Message-ID: <20060623115909.068c09af@localhost.localdomain>
In-Reply-To: <20060614120733.GF15061@sergelap.austin.ibm.com>
References: <20060614120733.GF15061@sergelap.austin.ibm.com>
Organization: IBM
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2006 07:07:33 -0500
"Serge E. Hallyn" <serue@us.ibm.com> wrote:

> Two variables in drivers/s390/net/qeth_main.c:qeth_send_packet()
> are only used if CONFIG_QETH_PERF_STATS.  Move their definition
> under the same ifdef to remove compiler warning.
> 
> Signed-off-by: Serge Hallyn <serue@us.ibm.com>
> 
> ---
> 
>  drivers/s390/net/qeth_main.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> 74bcd2e9461534ccd39ec84455b0b2c07c7f24a5
> diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
> index 9e671a4..8f8c0f4 100644
> --- a/drivers/s390/net/qeth_main.c
> +++ b/drivers/s390/net/qeth_main.c
> @@ -4416,8 +4416,10 @@ qeth_send_packet(struct qeth_card *card,
>  	enum qeth_large_send_types large_send = QETH_LARGE_SEND_NO;
>  	struct qeth_eddp_context *ctx = NULL;
>  	int tx_bytes = skb->len;
> +#ifdef CONFIG_QETH_PERF_STATS
>  	unsigned short nr_frags = skb_shinfo(skb)->nr_frags;
>  	unsigned short tso_size = skb_shinfo(skb)->tso_size;
> +#endif
>  	int rc;
>  
>  	QETH_DBF_TEXT(trace, 6, "sendpkt");

Hi Serge,

thanks for the patch...Applied ...
I will send it out with the next patch series .

Frank
