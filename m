Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268183AbUHaMtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268183AbUHaMtA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 08:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268325AbUHaMrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 08:47:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62662 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268144AbUHaMl7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 08:41:59 -0400
Date: Tue, 31 Aug 2004 08:16:21 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPMI driver updates for 2.4
Message-ID: <20040831111621.GE4615@logos.cnet>
References: <411EB8F1.5040209@acm.org> <20040823132820.GB2157@logos.cnet> <4132A17A.8060607@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4132A17A.8060607@acm.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Corey, 

You wrote a nice changelog entry - thanks for that.

I'm not sure if we should apply all of this in v2.4. It looks like a
big driver revamp to me. 

Is is all this critical for being merged in v2.4.x now? 

Would it be very painful/unwanted to maintain only the bugfixes 
and not only new features? What you think about that?

On Sun, Aug 29, 2004 at 10:39:38PM -0500, Corey Minyard wrote:
> Marcelo Tosatti wrote:
> 
> >Corey,
> >
> >Care to write a detailed changelog so we can apply this?
> >
> >Thanks
> >
> > 
> >
> I'm sorry this took so long, I have been dealing with disasters at work.
> 
> Ok, a detailed changelog:
> 
> * Add a new "system interface" driver that supports all the standard
>  IPMI system interfaces (SMIC, BT, and KCS, see the IPMI spec for
>  more details if you care).  This driver will auto-detect the interface
>  type and parameters via SMBIOS or ACPI tables.
> * Deprecate the old KCS-only interface.
> * Support non-contiguous registers for system interfaces.
> * Add support for IPMI LAN bridging so messages can be received
>  from and sent to system software connected to a LAN interface.
> * Add support for powering off the system on a halt via the IPMI
>  interface.
> * Add support for storing panic logs in the IPMI event log.
> * Allow control of message parameters (resends, timeouts)
> 
> I've also re-attached the patch.
> 
> Thanks,
