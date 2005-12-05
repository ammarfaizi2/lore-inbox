Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbVLEE5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbVLEE5j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 23:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbVLEE5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 23:57:39 -0500
Received: from terminus.zytor.com ([192.83.249.54]:38571 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750907AbVLEE5j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 23:57:39 -0500
Message-ID: <4393C8BF.9010209@zytor.com>
Date: Sun, 04 Dec 2005 20:57:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Rustad <mrustad@mac.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: virtual interface mac adress
References: <20051204192958.64093.qmail@web60214.mail.yahoo.com> <Pine.LNX.4.63.0512041520320.29211@cuia.boston.redhat.com> <dmvk9i$631$1@terminus.zytor.com> <4CA89BCD-690D-45F8-864C-E0CE1CCC832C@mac.com>
In-Reply-To: <4CA89BCD-690D-45F8-864C-E0CE1CCC832C@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rustad wrote:
> 
> Theoretically that is true, however there are usages that have been  
> approved that violate that principal. One was for TI Token Ring  chips. 
> They were completely unable to use "global" MAC addresses -  the local 
> bit always had to be set. Since TI could/would not fix  their chips, 
> using the local address became allowed for a universally  unique address.
> 
> This method was later used by Apple on Ethernet for their DOS card.  The 
> Macintosh environment would get the global address and the DOS  card 
> would get the local one through the shared ethernet port. You  might 
> think that you can ignore the token ring case, but you'd be  wrong - 
> there are ethernet/token ring bridges deployed. The Apple  case is also 
> best not ignored. I don't know how many others may be  doing similar 
> things.
> 
> So, I would not advise anyone to simply believe that they can use the  
> entire local MAC address space safely. You are also very likely to  have 
> trouble if there is any DECnet usage in the area. Anyone else  notice 
> that DECnet kernel patch recently? Someone must still be using  it...
> 
> This is an instance where Linus' comment a few weeks ago regarding  
> specs vs. reality comes into play. This is kind of an obscure area so  
> not a whole lot of people know about some of these things. Don't  
> believe everything you read in magazines regarding MAC addresses  
> either. I've seen some very bad advice there from time to time in  this 
> particular area.
> 
> I would recommend using the same MAC address with the local bit set  (as 
> Apple did) for a single additional address. If you need more  addresses 
> and need them to be visible on the LAN, I don't know of a  reliable, 
> generic solution off the top of my head.
> 

By definition, using local addresses is probabilistic.  There are moron 
hardware manufacturers, as you show above (which aren't even the worst 
of the lot, from what I've seen), but your cross-section with other 
local-address users will be very small (collision only likely around 
2^23 nodes.)

Reducing the address space available to randomly pick from will only 
increase the likelihood of failure.

This is an instance where an understanding of statistics come into play.

	-hpa
