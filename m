Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbSLRQ6n>; Wed, 18 Dec 2002 11:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264842AbSLRQ6n>; Wed, 18 Dec 2002 11:58:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27910 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264799AbSLRQ6m>;
	Wed, 18 Dec 2002 11:58:42 -0500
Message-ID: <3E00AB03.8010808@pobox.com>
Date: Wed, 18 Dec 2002 12:06:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       manfred@colorfullife.com
Subject: Re: [PATCH] sys_poll SuS compliance fix
References: <200212181631.gBIGVLJ11794@hera.kernel.org>
In-Reply-To: <200212181631.gBIGVLJ11794@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.942, 2002/12/18 10:33:48-02:00, manfred@colorfullife.com
> 
> 	[PATCH] sys_poll SuS compliance fix

> diff -Nru a/fs/select.c b/fs/select.c
> --- a/fs/select.c	Wed Dec 18 08:31:22 2002
> +++ b/fs/select.c	Wed Dec 18 08:31:22 2002
> @@ -417,7 +417,7 @@
>  	int nchunks, nleft;
>  
>  	/* Do a sanity check on nfds ... */
> -	if (nfds > NR_OPEN)
> +	if (nfds > current->files->max_fdset && nfds > OPEN_MAX)
>  		return -EINVAL;



The changeset description is awful, can you give us more details 
Manfred?  [also in the future can you please give Linus more description 
  with your patches?]

In particular, I wonder if "||" is more appropriate than "&&"?

	Jeff



