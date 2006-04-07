Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWDGNaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWDGNaz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 09:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWDGNaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 09:30:55 -0400
Received: from mx02.cybersurf.com ([209.197.145.105]:31131 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S964785AbWDGNay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 09:30:54 -0400
Subject: Re: Broadcast ARP packets on link local addresses (Version2).
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: David Daney <ddaney@avtrex.com>
Cc: Janos Farkas <chexum+dev@gmail.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, pgf@foxharp.boston.ma.us,
       freek@macfreek.nl
In-Reply-To: <44353F36.9070404@avtrex.com>
References: <17460.13568.175877.44476@dl2.hq2.avtrex.com>
	 <priv$efbe06144502$2d51735f79@200604.gmail.com>
	 <44353F36.9070404@avtrex.com>
Content-Type: text/plain
Organization: unknown
Date: Fri, 07 Apr 2006 09:30:38 -0400
Message-Id: <1144416638.5082.33.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-04 at 09:17 -0700, David Daney wrote:
> Janos Farkas wrote:

> > Sorry for chiming in this late in the discussion, but...  Shouldn't it
> > be more correct to not depend on the ip address of the used network,
> > but to use the "scope" parameter of the given address?
> > 
> 

Excellent point! It was bothering me as well but i couldnt express my
view eloquently as you did.

> RFC 3927 specifies the Ethernet arp broadcast behavior for only 
> 169.254.0.0/16.

Thats besides the point. You could, for example, use 1.1.1.1/24 in your
network instead of the 10.x or 192.x; and i have seen people use 10.x
in what appears to be public networks. We dont have speacial checks for 
RFC 1918 IP addresses for example.

169.254.0.0/16 is by definition link local. I think point made by Janos
is we should look at the attributes rather than value.

Have your user space set it to be link local and then fix the kernel if
it doesnt do the right thing.

>   Presumably you could set the scope parameter to local 
> for addresses outside of that range or even for protocols other than 
> Ethernet.  Since broadcasting ARP packets usually adversely effects 
> usable network bandwidth, we should probably only do it where it is 
> absolutely required.  The overhead of testing the value required by the 
> RFC is quite low (3 machine instructions on i686 is the size of the 
> entire patch), so using some proxy like the scope parameter would not 
> even be a performance win.
> 

Again, that is beside the point. 

cheers,
jamal

