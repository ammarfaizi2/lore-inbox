Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbULQWot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbULQWot (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 17:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbULQWot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 17:44:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29876 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262213AbULQWor
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 17:44:47 -0500
Message-ID: <41C36150.6050108@pobox.com>
Date: Fri, 17 Dec 2004 17:44:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>, akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcapatch work for all bk transports
References: <Pine.LNX.4.61.0412171343250.26684@linen.sps.mot.com>
In-Reply-To: <Pine.LNX.4.61.0412171343250.26684@linen.sps.mot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala wrote:
> Andrew,
> 
> Makes the gcapatch script work for any bk transport (including http).
> 
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
> 
> --
> 
> diff -Nru a/Documentation/BK-usage/gcapatch b/Documentation/BK-usage/gcapatch
> --- a/Documentation/BK-usage/gcapatch	2004-12-17 13:42:32 -06:00
> +++ b/Documentation/BK-usage/gcapatch	2004-12-17 13:42:32 -06:00
> @@ -5,4 +5,4 @@
>  # Usage: gcapatch > foo.patch
>  #
>  
> -bk export -tpatch -hdu -r`bk repogca bk://linux.bkbits.net/linux-2.5`,+
> +bk export -tpatch -hdu -r$(bk repogca $(bk parent -p)),+

It's an example script, meant to be modified to suit your local tastes.

Your patch isn't useful for situations (such as mine :)) where you have 
more than one level of parent, but you want to generate a patch versus 
mainline (not the parent).

	Jeff


