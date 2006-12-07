Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032278AbWLGOvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032278AbWLGOvT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 09:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032277AbWLGOvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 09:51:19 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:46220 "HELO
	smtp108.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1032279AbWLGOvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 09:51:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=CUY2ya/It2RPSEIDLnvWqdtHVv5R2lHbGAAOx1CeR6+BufawhN7Ab5yq5/lTsHRhd5INSgSZHySiVAEBLM5uQUtUZjQBuW8Z614LWfctiySDHtvpfKtT3wCRxnnpIe9P59YZDfeDeULnxTx4LMmqcHplR/nmqZBqPT1+0nhlgaM=  ;
X-YMail-OSG: gNke3W8VM1m9nqIemPeBhTDoLttjVXc1dyVFiOSqOaGgCzto1HlFW7InmeDeX6EmZvV3y75QfmEtJM0MlAtTO0_Sh2oqmuBPeB1qR_j40gbzvvKy1nU8Vk3H4oNMea96fQ07TjuEKXRiHUDWy2K9nG7iXm3QZrTIFAUtc0raZaROaiTzZRSjQ8a11N8i
From: David Brownell <david-b@pacbell.net>
To: linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [PATCH] WorkStruct: Fix spi_bitbang.h
Date: Thu, 7 Dec 2006 06:50:47 -0800
User-Agent: KMail/1.7.1
Cc: David Howells <dhowells@redhat.com>, ben@fluff.org, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20061207124419.17680.96380.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061207124419.17680.96380.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612070650.49232.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 December 2006 4:44 am, David Howells wrote:
> Fix spi_bitbang.h.  It need to #include <linux/workqueue.h> before it can
> compile.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>

NAK.  Headers don't compile.  A driver including this _might_ need to
include that header; most won't.


> ---
> 
>  include/linux/spi/spi_bitbang.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
> index 16ce178..33fa727 100644
> --- a/include/linux/spi/spi_bitbang.h
> +++ b/include/linux/spi/spi_bitbang.h
> @@ -1,6 +1,8 @@
>  #ifndef	__SPI_BITBANG_H
>  #define	__SPI_BITBANG_H
>  
> +#include <linux/workqueue.h>
> +
>  /*
>   * Mix this utility code with some glue code to get one of several types of
>   * simple SPI master driver.  Two do polled word-at-a-time I/O:
> 
>
