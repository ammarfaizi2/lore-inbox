Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266520AbUA2Xby (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 18:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266522AbUA2Xbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 18:31:53 -0500
Received: from fmr03.intel.com ([143.183.121.5]:11412 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S266520AbUA2Xbu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 18:31:50 -0500
Subject: Re: 2.6.2-rc2-bk1 oopses on boot (ACPI patch)
From: Len Brown <len.brown@intel.com>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi <linux-acpi@intel.com>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0020AE8AD@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0020AE8AD@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1075419074.2497.203.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 29 Jan 2004 18:31:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro,
Looks like you've identifed a regression, probably in ACPI.

Please test the 1st patch attached to this bug report
http://bugzilla.kernel.org/show_bug.cgi?id=1766

If it doesn't address the problem, please file an additional bug report
per below.

thanks,
-Len

ps.
The divide-by zero symptom should be addressed by Dominik's update, now
in the ACPI tree and thus the next -mm patch.

pps.
How to file a bug against ACPI:

http://bugzilla.kernel.org/ Category: Power Management, Component: ACPI

Please attach dmesg -s40000 output (or serial console log if dmesg
unavailable)

Please attach the output from acpidmp, available in /usr/sbin/, or in
pmtools:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

On Wed, 2004-01-28 at 17:32, Alessandro Suardi wrote:
> Matt Domsch wrote:
> > On Tue, Jan 27, 2004 at 11:37:55PM -0500, Dmitry Torokhov wrote:
> >
> >>>Divide by zero.  Looks like ACPI is now passing bad values into the
> >>>frequency change notifier.
...
> , I'd like to remind that this works
>   perfectly prior to the 20031203 ACPI patch. Indeed, this is what
>   2.6.1 vanilla says in that area:
> 
> cpufreq: CPU0 - ACPI performance management activated.
> cpufreq: *P0: 1800 MHz, 0 mW, 250 uS
> cpufreq:  P1: 1200 MHz, 0 mW, 250 uS
> 
> Attaching the gzipped dmesg for my 2.6.1 boot - let me know if
>   you want anyway dmidecode output and DSDT; for this latter I'll
>   have to ask for instructions (or is the output of a simple
>   'cat /proc/acpi/dsdt' enough ?).
> 
> --alessandro
> 
>   "Two rivers run too deep
>    The seasons change and so do I"
>        (U2, "Indian Summer Sky")
> 
> 

