Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312204AbSCRGEc>; Mon, 18 Mar 2002 01:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312205AbSCRGEY>; Mon, 18 Mar 2002 01:04:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31498 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312204AbSCRGEP>;
	Mon, 18 Mar 2002 01:04:15 -0500
Message-ID: <3C958332.4050508@mandrakesoft.com>
Date: Mon, 18 Mar 2002 01:03:30 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: rusty@rustcorp.com.au, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, rgooch@ras.ucalgary.ca
Subject: Re: bit ops on unsigned long?
In-Reply-To: <Pine.LNX.4.33.0203151656320.1379-100000@home.transmeta.com>	<E16m4YD-0004af-00@wagner.rustcorp.com.au> <20020317.200828.64296429.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>   From: Rusty Russell <rusty@rustcorp.com.au>
>   Date: Sat, 16 Mar 2002 14:08:08 +1100
>
>   +#ifdef CONFIG_PREEMPT
>    	/* Set the preempt count _outside_ the spinlocks! */
>    	idle->thread_info->preempt_count = (idle->lock_depth >= 0);
>   +#endif
>
>This part of your patch has to go.  Every port must
>provide the preempt_count member of thread_info regardless
>of the CONFIG_PREEMPT setting.
>

Even if the port doesn't support CONFIG_PREEMPT at all?

    Jeff






