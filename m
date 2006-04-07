Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWDGUim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWDGUim (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 16:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWDGUim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 16:38:42 -0400
Received: from [166.70.100.114] ([166.70.100.114]:57002 "EHLO mail.middle.net")
	by vger.kernel.org with ESMTP id S964942AbWDGUil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 16:38:41 -0400
Message-ID: <4436CDD2.7010303@middle.net>
Date: Fri, 07 Apr 2006 14:38:42 -0600
From: Mark Butler <butlerm@middle.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Daney <ddaney@avtrex.com>
CC: hadi@cyberus.ca, Janos Farkas <chexum+dev@gmail.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       pgf@foxharp.boston.ma.us, freek@macfreek.nl
Subject: Re: Broadcast ARP packets on link local addresses (Version2).
References: <17460.13568.175877.44476@dl2.hq2.avtrex.com>	 <priv$efbe06144502$2d51735f79@200604.gmail.com>	 <44353F36.9070404@avtrex.com> <1144416638.5082.33.camel@jzny2> <443690C9.5090500@avtrex.com>
In-Reply-To: <443690C9.5090500@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 67.137.150.193
X-SA-Exim-Mail-From: butlerm@middle.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Daney wrote:

> Following your logic through, It seems that you are advocating 
> broadcasting *all* ARP packets on *all* link local addresses.  That 
> would mean that on a 192.168.* switched Ethernet network with DHCP 
> that twice as many ARP packets would be broadcast.

192.168.* addresses are not considered "link local", they are rather 
"private" or "site local" addresses.

> The scope parameter, as far as I can tell, is used to make routing 
> decisions.  Overloading it to also implement the RFC 3927 ARP 
> broadcasting requirement would result in generation of unnecessary 
> network traffic in configurations that are probably the majority of 
> Linux deployments.

No extra network traffic, but there is some measurable overhead to 
looking up the scope in the routing table.

One problem is having this type of scheme behave properly by default, 
i.e. in the absence of user specified entries.  Having to create an 
entry for every interface in the system just to get RFC standard 
behavior is silly.

- Mark
