Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWF0RSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWF0RSH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWF0RSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:18:07 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:24508 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932494AbWF0RSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:18:05 -0400
Subject: Re: [PATCH 2/7] bootmem: mark link_bootmem() as part of the __init
	section
From: Dave Hansen <haveblue@us.ibm.com>
To: Franck <vagabon.xyz@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <44A12A4F.8030204@innova-card.com>
References: <449FDD02.2090307@innova-card.com>
	 <1151344691.10877.44.camel@localhost.localdomain>
	 <44A12A4F.8030204@innova-card.com>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 10:17:45 -0700
Message-Id: <1151428665.24103.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 14:53 +0200, Franck Bui-Huu wrote:
> Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
> ---
>  mm/bootmem.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/mm/bootmem.c b/mm/bootmem.c
> index d213fed..d0a34fe 100644
> --- a/mm/bootmem.c
> +++ b/mm/bootmem.c
> @@ -56,7 +56,7 @@ unsigned long __init bootmem_bootmap_pag
>  /*
>   * link bdata in order
>   */
> -static void link_bootmem(bootmem_data_t *bdata)
> +static void __init link_bootmem(bootmem_data_t *bdata)
>  {
>  	bootmem_data_t *ent;
>  	if (list_empty(&bdata_list)) {

Looks sane.  Just curious, did you do any wider audit in bootmem.c for
more of these?

-- Dave

