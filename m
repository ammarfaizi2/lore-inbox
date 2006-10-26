Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423406AbWJZFYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423406AbWJZFYe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 01:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423409AbWJZFYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 01:24:33 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:52611 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1423404AbWJZFYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 01:24:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=5ODzJ724tsQLwRUYcP0RFAohBep0YeHxiKGMDUQe/yjMc69rKYFu42pzTIvUsXs04LSj9asqu4Tq5kY5fiMkUayycD7PZEQWRQXLpht5zQym1pcCGbfYLxRmFmH+dk1qTg2FWfwVjSd58dHazz8cCIjMksZ5a8zMjAEHvXst400=  ;
From: David Brownell <david-b@pacbell.net>
To: "Randy.Dunlap" <randy.dunlap@oracle.com>
Subject: Re: [PATCH 1/2] !CONFIG_NET_ETHERNET unsets CONFIG_PHYLIB, but  CONFIG_USB_USBNET also needs CONFIG_PHYLIB
Date: Wed, 25 Oct 2006 22:24:27 -0700
User-Agent: KMail/1.7.1
Cc: toralf.foerster@gmx.de, netdev@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, link@miggy.org, greg@kroah.com,
       akpm@osdl.org, zippel@linux-m68k.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <200610251924.04321.david-b@pacbell.net> <45404237.3070307@oracle.com>
In-Reply-To: <45404237.3070307@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610252224.28300.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 October 2006 10:05 pm, Randy.Dunlap wrote:

> > 
> > ... MII should still depend on ETHERNET, right?
> > Just not limited to 10/100 Ethernet.
> 
> There is no such config symbol.  NET_ETHERNET means 10/100 ethernet.
> Gigabit ethernet doesn't use the ETHERNET symbol (and doesn't use
> this flavor of MII IIRC).

Ah, you're right -- sorry.  Only Kconfig and net/ipv4/arp.c even
look for that config symbol.

- Dave

