Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbVHZPTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbVHZPTG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 11:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbVHZPTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 11:19:05 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:57487 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965075AbVHZPTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 11:19:04 -0400
Subject: Re: [OT] volatile keyword
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Vadim Lobanov <vlobanov@speakeasy.net>, linux-kernel@vger.kernel.org,
       tom.anderl@gmail.com
In-Reply-To: <430E37A0.1000304@nortel.com>
References: <Pine.LNX.4.58.0508251335280.4315@shell2.speakeasy.net>
	 <430E30B2.1020700@nortel.com>
	 <Pine.LNX.4.58.0508251414350.19866@shell2.speakeasy.net>
	 <430E37A0.1000304@nortel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 26 Aug 2005 16:39:58 +0100
Message-Id: <1125070798.4958.99.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-08-25 at 15:26 -0600, Christopher Friesen wrote:
> > do
> >     expires = timr->it_timer.expires;
> > while ((volatile long) (timr->it_timer.expires) != expires);
> > 
> > Seems it's casting the value, not the pointer.
> 
> Someone else will have to give the definitive answer, but it looks 
> suspicious to me...

It really ought to be using rmb() in this case not volatile casting

Alan

