Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVBUBvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVBUBvF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 20:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVBUBvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 20:51:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17590 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261178AbVBUBu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 20:50:56 -0500
Message-ID: <42193E72.2090708@pobox.com>
Date: Sun, 20 Feb 2005 20:50:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: acme@conectiva.com.br, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/appletalk/: make firmware static
References: <20050217150351.GM24808@stusta.de>
In-Reply-To: <20050217150351.GM24808@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch makes some needlessly global firmware static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/net/appletalk/cops_ffdrv.h |    2 +-
>  drivers/net/appletalk/cops_ltdrv.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.11-rc3-mm2-full/drivers/net/appletalk/cops_ffdrv.h.old	2005-02-16 15:15:32.000000000 +0100
> +++ linux-2.6.11-rc3-mm2-full/drivers/net/appletalk/cops_ffdrv.h	2005-02-16 15:15:41.000000000 +0100
> @@ -28,7 +28,7 @@
>  
>  #ifdef CONFIG_COPS_DAYNA
>  
> -unsigned char ffdrv_code[] = {
> +static unsigned char ffdrv_code[] = {
>  	58,3,0,50,228,149,33,255,255,34,226,149,
>  	249,17,40,152,33,202,154,183,237,82,77,68,
>  	11,107,98,19,54,0,237,176,175,50,80,0,
> --- linux-2.6.11-rc3-mm2-full/drivers/net/appletalk/cops_ltdrv.h.old	2005-02-16 15:15:50.000000000 +0100
> +++ linux-2.6.11-rc3-mm2-full/drivers/net/appletalk/cops_ltdrv.h	2005-02-16 15:15:58.000000000 +0100
> @@ -27,7 +27,7 @@
>  
>  #ifdef CONFIG_COPS_TANGENT
>  
> -unsigned char ltdrv_code[] = {
> +static unsigned char ltdrv_code[] = {

const


