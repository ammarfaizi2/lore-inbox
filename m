Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265316AbUEZG2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265316AbUEZG2t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 02:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265319AbUEZG2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 02:28:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:726 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265316AbUEZG2s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 02:28:48 -0400
Message-ID: <40B43913.7010207@pobox.com>
Date: Wed, 26 May 2004 02:28:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Don't return void types from void functions.
References: <200405260606.i4Q66dXB023475@hera.kernel.org>
In-Reply-To: <200405260606.i4Q66dXB023475@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> diff -Nru a/drivers/net/tokenring/olympic.c b/drivers/net/tokenring/olympic.c
> --- a/drivers/net/tokenring/olympic.c	2004-05-25 23:06:49 -07:00
> +++ b/drivers/net/tokenring/olympic.c	2004-05-25 23:06:49 -07:00
> @@ -1806,7 +1806,7 @@
>  
>  static void __exit olympic_pci_cleanup(void)
>  {
> -	return pci_unregister_driver(&olympic_driver) ; 
> +	pci_unregister_driver(&olympic_driver) ; 
>  }	


Can we make gcc error out when it finds this?

	Jeff


