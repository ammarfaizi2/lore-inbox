Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTEEXK0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 19:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbTEEXK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 19:10:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12751 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262056AbTEEXKU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 19:10:20 -0400
Message-ID: <3EB6F23C.9030006@pobox.com>
Date: Mon, 05 May 2003 19:22:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] PATCH: fix qlogicisp leaks
References: <200305052311.h45NBYVe017478@hera.kernel.org>
In-Reply-To: <200305052311.h45NBYVe017478@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1164, 2003/05/05 15:30:53-03:00, alan@lxorguk.ukuu.org.uk
> 
> 	[PATCH] PATCH: fix qlogicisp leaks


> @@ -1396,13 +1396,6 @@
>  		return 1;
>  	}
>  
> -#ifdef __alpha__
> -	/* Force ALPHA to use bus I/O and not bus MEM.
> -	   This is to avoid having to use HAE_MEM registers,
> -	   which is broken on some platforms and with SMP.  */
> -	command &= ~PCI_COMMAND_MEMORY; 
> -#endif
> -
>  	if (!(command & PCI_COMMAND_MASTER)) {
>  		printk("qlogicisp : bus mastering is disabled\n");
>  		return 1;


Um.  Why did this "leak fix" just break alpha?

	Jeff



