Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272950AbTHKRtJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272974AbTHKRqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:46:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13036 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272973AbTHKRpo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:45:44 -0400
Message-ID: <3F37D63A.8010500@pobox.com>
Date: Mon, 11 Aug 2003 13:45:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: davej@redhat.com
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove useless assertions from reiserfs
References: <E19mFqr-00068B-00@tetrachloride>
In-Reply-To: <E19mFqr-00068B-00@tetrachloride>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why are these useless?

davej@redhat.com wrote:
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/reiserfs/hashes.c linux-2.5/fs/reiserfs/hashes.c
> --- bk-linus/fs/reiserfs/hashes.c	2003-04-10 06:01:29.000000000 +0100
> +++ linux-2.5/fs/reiserfs/hashes.c	2003-07-13 06:04:57.000000000 +0100
> @@ -90,10 +90,6 @@ u32 keyed_hash(const signed char *msg, i
>  
>  	if (len >= 12)
>  	{
> -	    	//assert(len < 16);
> -		if (len >= 16)
> -		    BUG();
> -
>  		a = (u32)msg[ 0]      |
>  		    (u32)msg[ 1] << 8 |
>  		    (u32)msg[ 2] << 16|

Seems like a valid check to me...

	Jeff




