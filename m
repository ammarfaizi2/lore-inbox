Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVAPWSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVAPWSp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 17:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVAPWRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 17:17:51 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:44677 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262629AbVAPWPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 17:15:22 -0500
Subject: Re: [PATCH 0/13] remove cli()/sti() in drivers/char/*
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: James Nelson <james4765@cwazy.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitors@lists.osdl.org
In-Reply-To: <20050116130452.10fabe52.akpm@osdl.org>
References: <20050116135223.30109.26479.55757@localhost.localdomain>
	 <20050116130452.10fabe52.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105908079.12201.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 16 Jan 2005 21:10:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-01-16 at 21:04, Andrew Morton wrote:
> James Nelson <james4765@cwazy.co.uk> wrote:
> >
> > This series of patches removes the last cli()/sti()/save_flags()/restore_flags()
> >  function calls in drivers/char.
> 
> I don't see much point in this, really.  Those cli() calls are a big fat
> sign saying "broken on smp" and they now generate compile-time warnings
> emphasising that.  These drivers still need to be fixed up - we may las
> well leave them as-is until someone gets onto doing that.

Please drop all the serial ones. I'm slowly working through the serial
drivers that are relevant to any kind of users and fixing them up or
importing fixes from vendor branches as appropriate.

Simple substitions don't work here, and in some cases even simple tty
device locks because many cards are chip level interfaces not port
level.

Alan

