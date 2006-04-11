Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWDKWdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWDKWdd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWDKWdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:33:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26597 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751176AbWDKWdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:33:32 -0400
Date: Tue, 11 Apr 2006 15:33:15 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: John Heffner <jheffner@psc.edu>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 regression: Very slow net transfer from some hosts
Message-ID: <20060411153315.4132b477@localhost.localdomain>
In-Reply-To: <443C2BBA.5010804@gentoo.org>
References: <443C03E6.7080202@gentoo.org>
	<443C024C.2070107@psc.edu>
	<443C0B74.50305@gentoo.org>
	<443C09A7.2040900@psc.edu>
	<443C1738.20605@gentoo.org>
	<443C178B.3030805@psc.edu>
	<443C2BBA.5010804@gentoo.org>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2006 23:20:42 +0100
Daniel Drake <dsd@gentoo.org> wrote:

> John Heffner wrote:
> > This is almost certainly due to a buggy firewall that doesn't understand 
> > TCP window scaling.  I've usually seen this in the past with OpenBSD 
> > firewalls.  Do you have one of these in your path?
> 
> At home I'm behind a Linux gateway box currently running 2.6.15-rc6 - I 
> am connected through ethernet to that.
> 
> At my student house I am connected wirelessly to a Linksys WRT54Gv5 
> router (the model that doesnt run Linux).
> 
> I have reproduced it at both those locations (same ISP).
> 
> This is very familiar, and I just found the article I was thinking of: 
> http://lwn.net/Articles/92727/
> 
> I was also hit by that bug, on the same collection of websites, but that 
> particular problem was fixed for 2.6.8 or so. So I guess it is extremely 
> likely that my ISP has broken routers. nmap isn't able to identify the 
> OS of any ISP routers in my path.

We never fixed it, its kind of hard to fix other peoples equipment ;-)

> 
> It's a huge ISP over here, so contacting them over technical matters is 
> not easy...
> 
> Thanks,
> Daniel
> 

Turn off TCP window scaling, your performance will be limited but about
as good as you can get with a corrupting firewall in between.
