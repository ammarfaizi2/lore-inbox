Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSJAIYo>; Tue, 1 Oct 2002 04:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSJAIYo>; Tue, 1 Oct 2002 04:24:44 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:5525 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261527AbSJAIYn>; Tue, 1 Oct 2002 04:24:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] 2.5.39 s390 (3/26): drivers.
Date: Tue, 1 Oct 2002 12:29:54 +0200
User-Agent: KMail/1.4.3
Cc: Arjan van de Ven <arjanv@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Cornelia Huck <cohuck@de.ibm.com>
References: <1033396763.1718.1.camel@localhost.localdomain> <200209301957.04743.arnd@bergmann-dalldorf.de> <20021001005521.GA4331@kroah.com>
In-Reply-To: <20021001005521.GA4331@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210011229.54409.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 October 2002 02:55, Greg KH wrote:

> With the last patch I just sent to Linus, I think you have everything
> you need (from the driver core, exported to /sbin/hotplug.)  Let me know
> if there's any changes that can help you out.

Great! I'll be on holidays for the rest of this week, but Cornelia
should look if there are any conflicts with what we need to support
the 'multiple subchannel devices make up a network device' scheme
that our architecture dictates.

On the user space side I still have one patch for modutils to implement
modules.ccwmap. I want to be sure that its interface is stable
before submitting it, though.

> I'll work on adding /sbin/hotplug support for classes later this week,
> but I don't think your code would need that, correct?
Not initially, but if the 'single major for all disks' stuff that has 
been discussed makes it into 2.5, we have to make sure that dasd works
with that.
We already have a hotplug implementation for 2.4 dasd that could be
ported instead, but a generic solution would be much nicer.

	Arnd <><
