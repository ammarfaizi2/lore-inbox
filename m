Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263134AbUFNOX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUFNOX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 10:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUFNOWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 10:22:31 -0400
Received: from fmr11.intel.com ([192.55.52.31]:61149 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S263126AbUFNOVH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 10:21:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Panics need better handling
Date: Mon, 14 Jun 2004 10:20:48 -0400
Message-ID: <D9C3AB0C3EE2254099B606A10047B5F60C3185@hdsmsx403.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Panics need better handling
Thread-Index: AcRR4p4LD4IESOgTSFmlG3iy3pAS/wANroug
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "John Bradford" <john@grabjohn.com>,
       "Helge Hafting" <helgehaf@aitel.hist.no>, <ndiamond@despammed.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Jun 2004 14:20:49.0092 (UTC) FILETIME=[CA5CC040:01C4521A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For Intel servers, there is some help in 2.4.  It is now included within
the OpenIPMI driver.
It saves the panic info into a firmware log.
See http://sourceforge.net/projects/openipmi/ and http://panicsel.sf.net
(more info, plus a 'showsel' utility to view the firmware log).

The parameter to save this isn't turned on by default in OpenIPMI, but
it is there in 2.4 kernels (CONFIG_IPMI_PANIC_EVENT).  

Andy Cress

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of John Bradford
Sent: Monday, June 14, 2004 3:44 AM
To: Helge Hafting; ndiamond@despammed.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Panics need better handling


Quote from Helge Hafting <helgehaf@aitel.hist.no>:
> ndiamond@despammed.com wrote:
> 
> > I am not asking for
> >help in solving this particular panic,
> >I am asking for help in general, in
> >getting information displayed when it
> >needs to be displayed.
> >  
> >
> I have struggled with this from time to time.  Wanting to
> report a trace, but it is too long for the screen. 
> 
> Using a framebuffer console helps a lot.  I use 1280x1024 resolution,
> and 8x8 characters.  The resulting 160x128 console isn't
> that fun to _work_ with, but most panics/oopses fit.  I rarely
> work at the console anyway.  If you do, consider making two almost
> identical kernels where console font size is the only difference.
(The
> extra compile takes very little time.)  Then use the small-font kernel
> when debugging.

On the other hand, if like me you use a text-based console almost
exclusively,
then the best course of action is probably to buy a real serial
terminal, (or
several :-) ), and configure one of them as the console.  Then you can
basically ignore the VGA display completely.

John.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
