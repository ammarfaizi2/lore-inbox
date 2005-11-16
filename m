Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbVKPV5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbVKPV5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbVKPV5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:57:10 -0500
Received: from intranet.networkstreaming.com ([24.227.179.66]:8148 "EHLO
	networkstreaming.com") by vger.kernel.org with ESMTP
	id S932601AbVKPV5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:57:09 -0500
Message-ID: <437BAB0B.1090504@davyandbeth.com>
Date: Wed, 16 Nov 2005 15:56:27 -0600
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: virtual NICs
References: <437B932F.3090607@davyandbeth.com> <Pine.LNX.4.61.0511161540080.5251@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511161540080.5251@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Nov 2005 21:56:38.0984 (UTC) FILETIME=[9EF91480:01C5EAF8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, thanks for the prompt response.

linux-os (Dick Johnson) wrote:

>Of course there is extra work! Any time something has to be checked
>(filtered), there is the overhead of the filtering. In the case of
>two or more IP addresses, the software has to perform an ARP on two
>or more IPs. This means that it needs to "listen" for more queries.
>Note that machines on Ethernet, communicate using their hardware-
>addresses i.e., the "IEEE station address". But, the initial route
>to the target machine needs to be set up by broadcasting an IP address,
>thereby asking everybody on the LAN if the IP address belongs to them.
>Hopefully only one machine answers. This sequence is called ARP
>(address resolution protocol).
>
>  
>
My question was whether the one being defined to eth0 has an advantage 
over the one assigned to eth0:0 since one is real and one is virtual.  
My uninformed instinct told me to wonder if the NIC hardware itself 
somehow gets told to handle the IP assigned to eth0 and something in the 
linux software has to handle the IP assigned to eth0:0

I realize that the machine will have to do more work total.  But I 
wonder if it's any more work than if the server has two NICs with two 
different IPs.

>Adding more IP addresses is like adding more machines as far as
>the source (perhaps a router) is concerned. Adding more IP addresses
>to a single host is sometimes necessary, but it is not without
>cost. Basically, don't do it unless it's necessary.
>
>  
>
It's necessary because of the in-born inability for name based virtual 
hosting to be done over SSL (though I think this inability was 
unnecessary in that it could have been relaxed if just a little bit of 
unsecured data could be transmitted in the SSL header allowing the 
server to make some decision based on that clear data.. but that's 
another matter).

Thanks again,
  Davy
