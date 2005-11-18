Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVKRXjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVKRXjh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 18:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVKRXjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 18:39:10 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4753 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751195AbVKRXjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 18:39:04 -0500
Date: Fri, 18 Nov 2005 23:34:14 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>, kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051118233413.GC2359@spitz.ucw.cz>
References: <20051115212942.GA9828@elf.ucw.cz> <20051115222549.GF17023@redhat.com> <1132342590.25914.86.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132342590.25914.86.camel@localhost.localdomain>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Even it were not for this, the whole idea seems misconcieved to me
> > anyway.
> 
> I'm sceptical too but several Win9x BIOS vendor suspend paths were
> implemented in roughly this way. I don't however see how you can
> co-ordinate the freeze with outstanding O_DIRECT DMA to user pages for
> one item.

I do not see a problem. swsusp process stops all other processes, freezes
the drivers, then asks for system snapshot. It certainly does *not* ask for
O_DIRECT........

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

