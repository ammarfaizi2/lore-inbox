Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423766AbWJaSWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423766AbWJaSWb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423764AbWJaSWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:22:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25305 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423763AbWJaSWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:22:30 -0500
Date: Tue, 31 Oct 2006 10:22:22 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: peter.hicks@poggs.co.uk, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Thousands of interfaces
Message-ID: <20061031102222.7ab1ed6b@freekitty>
In-Reply-To: <20061031.013154.122620846.davem@davemloft.net>
References: <20061031092550.GA8201@tufnell.london.poggs.net>
	<20061031.013154.122620846.davem@davemloft.net>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006 01:31:54 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: Peter Hicks <peter.hicks@poggs.co.uk>
> Date: Tue, 31 Oct 2006 09:25:50 +0000
> 
> [ Discussion belongs on netdev@vger.kernel.org, added to CC: ]
> 
> > I have a dual 3GHz Xeon machine with a 2.4.21 kernel and thousands (15k+) of
> > ipip tunnel interfaces.  These are being used to tunnel traffic from remote
> > routers, over a private network, and handed off to a third party.
>  ...
> > Is it possible to speed up creation of the interfaces?  Currently it takes
> > around 24 hours.  Is there are more efficient way to handle a very large
> > number of IP-IP tunnels?  Would upgrading to a 2.6 kernel be of use?
> 


2.4 has a several N^2 searches for interfaces (and is in deep freeze by now).
2.6 had several changes to handle 1000's of interfaces.


-- 
Stephen Hemminger <shemminger@osdl.org>
