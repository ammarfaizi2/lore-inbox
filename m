Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVBMQij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVBMQij (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 11:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVBMQij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 11:38:39 -0500
Received: from smtpout1.uol.com.br ([200.221.4.192]:23726 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261185AbVBMQhp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 11:37:45 -0500
Date: Sun, 13 Feb 2005 14:37:39 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: Re: irq 10: nobody cared! (was: Re: 2.6.11-rc3-mm1)
Message-ID: <20050213163738.GC4563@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050204103350.241a907a.akpm@osdl.org> <20050205224558.GB3815@ime.usp.br> <20050212222104.GA1965@node1.opengeometry.net> <20050212224715.GA8249@ime.usp.br> <20050212232134.GA2242@node1.opengeometry.net> <20050212235043.GA4291@ime.usp.br> <20050213014151.GA2735@node1.opengeometry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050213014151.GA2735@node1.opengeometry.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12 2005, William Park wrote:
> On Sat, Feb 12, 2005 at 09:50:43PM -0200, Rog?rio Brito wrote:
> > To prevent the matters of loosing track of what is being done, I only
> > changed one option at a time. I put the dmesg logs of all my attempts
> > at <http://www.ime.usp.br/~rbrito/ide-problem/>.
> > 
> > Please let me know if I can provide any other useful information.
> 
> Your 'dmesg' says
>     Warning: Secondary channel requires an 80-pin cable for operation.
> I assume it is.

Indeed, I have two HDs plugged on the Promise controller. One of them (the
first one) has a 80-pin cable and the bios configures it to use UDMA 4.

Since I only have one 80-ribbon cable, the second HD uses a 40-ribbon cable
and is configured as the master of the other channel of the Promise
controller (to avoid having problems with the first one and to increase the
performance, since IDE does not have the ability to "disconnect" devices).

Perhaps that is the problem? I will try to turn off the second drive for a
moment, but I guess that there shouldn't be such problems.

One thing that is curious is that since both HDs are on different channels
of the Promise controller (as masters), the BIOS configures the first one
(with the 80-pin cable) as UDMA 4 and the second one (with the 40-pin
cable) as UDMA 2.

Then, when Linux boots, it downgrades both devices to UDMA 2, including the
one with the 80-ribbon cable. Is that expected behaviour?

> Do you have MSI on by any chance?  (CONFIG_PCI_MSI)  If so, try kernel
> without it.  My motherboard exhibits runaway IRQ with it.

I don't know what MSI is (I only know of a manufacturer of motherboards
called MSI), but my motherboard is an Asus A7V with chipset VIA KT133 (not
the latter revision, VIA KT133A).


Thank you very much for your help, Rogério.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
