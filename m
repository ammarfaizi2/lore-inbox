Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267450AbUIUB0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267450AbUIUB0A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 21:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267447AbUIUBZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 21:25:59 -0400
Received: from fmr04.intel.com ([143.183.121.6]:6288 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S267440AbUIUBZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 21:25:49 -0400
Date: Mon, 20 Sep 2004 18:25:39 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Alex Williamson <alex.williamson@hp.com>, acpi-devel@lists.sourceforge.net,
       Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface support
Message-ID: <20040920182539.B17763@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com> <200409201812.45933.dtor_core@ameritech.net> <1095727925.8780.58.camel@mythbox> <200409202020.05776.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200409202020.05776.dtor_core@ameritech.net>; from dtor_core@ameritech.net on Mon, Sep 20, 2004 at 08:20:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 08:20:05PM -0500, Dmitry Torokhov wrote:
> On Monday 20 September 2004 07:52 pm, Alex Williamson wrote:
> > On Mon, 2004-09-20 at 18:12 -0500, Dmitry Torokhov wrote: 
> > > 
> > > Hi Anil,
> > > 
> > > I obviously failed to deliver my idea :) I meant that I would like add eject
> > > attribute (along with maybe status, hid and some others) to kobjects in
> > > /sys/firmware/acpi tree.
> > > 
> > 
> > Dmitry,
> > 
> >    See the patch I just posted to acpi-devel and lkml (Subject:
> > [PATCH/RFC] exposing ACPI objects in sysfs).  It exposes acpi objects as
> > you describe.   Something simple like:
> > 
> >  # cat /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/_EJ0
> > 
> > Will call the _EJ0 method on the ACPI device.  You can evaluate eject
> > dependencies using the _EJD method.
> > 
> > 	Alex
> > 
> 
> Alex,
> 
> While I think that your patch is very important and should be included (maybe
> if not as is if somebody has some objections but in some other form) I see it
> more like developer's tool. I imagined status, HID, eject etc. attributes to
> be sanitized interface to kernel's data, not necessarily causing re-evaluation.
> 
> So it could be like this:
> 
> /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/status
> /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/removable
> /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/lockable
> ..
> /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/eject

Ha..Now I got it and what you are saying sounds right
thing to do. I will invistigate more and will get back to
the mailing list hopefully with the patch:)

> 
> And your raw access to the ACPI methods could reside under raw:
> 
> /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/raw/_STA
> /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/raw/_RNV
> /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/raw/_LCK
> ..
> /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/raw/_EJ0
> 
> -- 
> Dmitry
