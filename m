Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRACSQO>; Wed, 3 Jan 2001 13:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbRACSQE>; Wed, 3 Jan 2001 13:16:04 -0500
Received: from Cantor.suse.de ([194.112.123.193]:41488 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129857AbRACSP4>;
	Wed, 3 Jan 2001 13:15:56 -0500
Date: Wed, 3 Jan 2001 18:45:24 +0100
From: Andi Kleen <ak@suse.de>
To: Sourav Sen <sourav@csa.iisc.ernet.in>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: is eth header is not transmitted
Message-ID: <20010103184524.A6896@gruyere.muc.suse.de>
In-Reply-To: <Pine.SOL.3.96.1010103223330.7550A-100000@kohinoor.csa.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.3.96.1010103223330.7550A-100000@kohinoor.csa.iisc.ernet.in>; from sourav@csa.iisc.ernet.in on Wed, Jan 03, 2001 at 10:59:48PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 10:59:48PM +0530, Sourav Sen wrote:
> 
> Hi,
> 	In the function ip_build_xmit(), immediately after
> sk_alloc_send_skb(), skb_reserve(skb, hh_len) is called. Now
> skb_reserve(skb,len) only increment the data pointer and tail pointer by 
> len amt.
> 
> 	Now in a particular hard_start_xmit() say for rtl8139, the data
> transfer is taking place from skb->data :
> 	outl(virt_to_bus(skb->data), ioaddr + TxAddr0 + entry*4)
> 
> So, I cannot understand, if transfer starts from data and not head, is
> ethrnet header not transmitted? what I am missing? 

An skb_put() 


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
