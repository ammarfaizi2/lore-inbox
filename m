Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbTLVK0N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 05:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbTLVK0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 05:26:13 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:9925 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264373AbTLVK0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 05:26:11 -0500
From: Hans-Peter Jansen <hpj@urpla.net>
To: "Feldman, Scott" <scott.feldman@intel.com>,
       "Ethan Weinstein" <lists@stinkfoot.org>, <linux-kernel@vger.kernel.org>
Subject: Re: minor e1000 bug
Date: Mon, 22 Dec 2003 11:26:01 +0100
User-Agent: KMail/1.5.4
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD71@orsmsx402.jf.intel.com>
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD71@orsmsx402.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312221126.01953.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

On Monday 22 December 2003 06:26, Feldman, Scott wrote:
> > I would also be interested in a statement from intel fellows on
> > the reasoning behind this decision, since every user of gkrellm

> >     /* Reset the timer */
> > -   mod_timer(&adapter->watchdog_timer, jiffies + 2 * HZ);
> > +   mod_timer(&adapter->watchdog_timer, jiffies + HZ);
> >  }
>
> That should be OK if you're not linked at half duplex or using a
> 82541/7 Ethernet controller.  e1000_smartspeed() and
> e1000_adaptive_ifs() are sensitive to the watchdog interval, so
> we'll need to make sure those are OK before adjusting the timer
> from 2 to 1 seconds.  This issue is tracker here:
> http://bugme.osdl.org/show_bug.cgi?id=1192.

Thanks for clarification and the pointers. Nice to know, that this 
issue is still under investigation.

Let me add, that your and your companies strong continuous linux 
commitment/support has influenced and will influence our future 
hardware decisions. 

And NICs are a crucial part of our diskless setups..

> -scott

Thanks again and merry christmas,

Pete

<dream OT>
If only some manufacturer would pick up the _existing_ pieces, and 
create a barebone like fanless Pentium M based system with a CSA 
attached 8254x NIC. Add SSD for swap/suspend, or get nbd to work for 
those, and be done with a low current consumption/low heat/zero dB 
system, which easily outperforms current local harddisk setups.

BTW: I do remember 0 dB computing back in the 80ies on my 8MHz, 4 MB
Atari ST. Oh, well..
</dream OT>

