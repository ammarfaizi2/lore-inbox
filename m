Return-Path: <linux-kernel-owner+w=401wt.eu-S1425565AbWLHPbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425565AbWLHPbW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425567AbWLHPbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:31:22 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:63057 "EHLO
	outbound2-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1425565AbWLHPbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:31:21 -0500
X-BigFish: VP
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Date: Fri, 8 Dec 2006 08:31:27 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
cc: "lkml" <linux-kernel@vger.kernel.org>, info-linux@ldcmail.amd.com,
       "akpm" <akpm@osdl.org>
Subject: Re: geode crypto is PCI device
Message-ID: <20061208153126.GC26801@cosmic.amd.com>
References: <LYRIS-4270-98126-2006.12.07-23.17.55--jordan.crouse#amd.com@whitestar.amd.com>
MIME-Version: 1.0
In-Reply-To: <LYRIS-4270-98126-2006.12.07-23.17.55--jordan.crouse#amd.com@whitestar.amd.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 08 Dec 2006 15:31:13.0347 (UTC)
 FILETIME=[E4E22930:01C71ADD]
X-WSS-ID: 69675ACB2KW2176026-02-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/06 22:16 -0800, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> This driver seems to be for a PCI device.

Indeed it is.  Nice catch.

> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

Acked-by: Jordan Crouse <jordan.crouse@amd.com>

> ---
>  drivers/crypto/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.19-git11.orig/drivers/crypto/Kconfig
> +++ linux-2.6.19-git11/drivers/crypto/Kconfig
> @@ -53,7 +53,7 @@ config CRYPTO_DEV_PADLOCK_SHA
>  
>  config CRYPTO_DEV_GEODE
>  	tristate "Support for the Geode LX AES engine"
> -	depends on CRYPTO && X86_32
> +	depends on CRYPTO && X86_32 && PCI
>  	select CRYPTO_ALGAPI
>  	select CRYPTO_BLKCIPHER
>  	default m
> 
> 
> ---
> 
> 
> 
> ---
> You are currently subscribed to info-linux@geode.amd.com
> as: jordan.crouse@amd.com
> To unsubscribe send a blank email to:
> leave-info-linux-4270J@whitestar.amd.com

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>


