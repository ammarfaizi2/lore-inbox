Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUBZRVl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 12:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbUBZRVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 12:21:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52667 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262897AbUBZRVh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 12:21:37 -0500
Message-ID: <403E2B14.7060003@pobox.com>
Date: Thu, 26 Feb 2004 12:21:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christophe Saout <christophe@saout.de>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][1/2] dm-crypt cleanups
References: <20040226162324.GA12597@leto.cs.pocnet.net>
In-Reply-To: <20040226162324.GA12597@leto.cs.pocnet.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:
> +#include <asm/atomic.h>
>  #include <asm/scatterlist.h>
>  
>  #include "dm.h"
>  
> +#define PFX	"crypt: "
> +
>  /*
>   * per bio private data
>   */
> @@ -416,7 +419,7 @@
>  	int key_size;
>  
>  	if (argc != 5) {
> -		ti->error = "dm-crypt: Not enough arguments";
> +		ti->error = PFX "Not enough arguments";
>  		return -EINVAL;
>  	}
>  


Looks good, except that PFX should be defined to "dm-crypt: " to reduce 
confusion...  "crypt" is rather generic, and could be construed to be 
unrelated to your module.

	Jeff



