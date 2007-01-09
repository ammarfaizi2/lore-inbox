Return-Path: <linux-kernel-owner+w=401wt.eu-S932480AbXAIW1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbXAIW1y (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbXAIW1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:27:54 -0500
Received: from mga03.intel.com ([143.182.124.21]:24517 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932477AbXAIW1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:27:52 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,164,1167638400"; 
   d="scan'208"; a="167092353:sNHT26470129"
Message-ID: <45A416E3.4010602@intel.com>
Date: Tue, 09 Jan 2007 14:27:47 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.9 (X11/20061228)
MIME-Version: 1.0
To: akpm@osdl.org, jeff@garzik.org
CC: linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: + git-netdev-all-e1000-fix.patch added to -mm tree
References: <200701092215.l09MFFu1016878@shell0.pdx.osdl.net>
In-Reply-To: <200701092215.l09MFFu1016878@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2007 22:27:48.0602 (UTC) FILETIME=[646F65A0:01C7343D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:
> The patch titled
>      git-netdev-all: e1000 fix
> has been added to the -mm tree.  Its filename is
>      git-netdev-all-e1000-fix.patch
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> ------------------------------------------------------
> Subject: git-netdev-all: e1000 fix
> From: Andrew Morton <akpm@osdl.org>
> 
> drivers/net/e1000/e1000_main.c:997:1: error: unterminated #ifdef                
> 
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/net/e1000/e1000_main.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff -puN drivers/net/e1000/e1000_main.c~git-netdev-all-e1000-fix drivers/net/e1000/e1000_main.c
> --- a/drivers/net/e1000/e1000_main.c~git-netdev-all-e1000-fix
> +++ a/drivers/net/e1000/e1000_main.c
> @@ -994,7 +994,6 @@ e1000_probe(struct pci_dev *pdev,
>  	   (adapter->hw.mac_type != e1000_82547))
>  		netdev->features |= NETIF_F_TSO;
>  
> -#ifdef NETIF_F_TSO6
>  	if (adapter->hw.mac_type > e1000_82547_rev_2)
>  		netdev->features |= NETIF_F_TSO6;
>  	if (pci_using_dac)
> _


doh, I wish I had not included that in my updated patch for -mm right now... I knew I 
should have posted this to Jeff first when I spotted it myself this morning ;)

Ack, of course.

Cheers,

Auke
