Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268577AbUHLO2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268577AbUHLO2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 10:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268578AbUHLO2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 10:28:24 -0400
Received: from fmr99.intel.com ([192.55.52.32]:42710 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S268577AbUHLO2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 10:28:22 -0400
Subject: Re: Allow userspace do something special on overtemp
From: Len Brown <len.brown@intel.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Dax Kelson <dax@gurulabs.com>, trenn@suse.de, seife@suse.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040812074002.GC29466@elf.ucw.cz>
References: <20040811085326.GA11765@elf.ucw.cz>
	 <1092269309.3948.57.camel@mentorng.gurulabs.com>
	 <1092281393.7765.141.camel@dhcppc4>  <20040812074002.GC29466@elf.ucw.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1092320883.5021.173.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 12 Aug 2004 10:28:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 03:40, Pavel Machek wrote:
> Hi!
> 
> > I think I'd rather see the calls to usermode deleted
> > instead of extended -- unless there is a reason that
> > the general event -> acpid method can't work.
> 
> See above, switching to acpid would break all the existing
> setups... in stable series.

ah, the price of progress.

I'm confident that the distros can figure out how to
update the (neglected) acpid scripts at the same time as
(or before) the kernel update.

If they can't, then ACPI critical shutdown will fail
(maybe on some systems not such a bad thing;-)
and TM1 will kick in, and if that doesn't work, TM2
will kick in, and if that doesn't work the processor
will disable itself.

In practice, the only time this will happen is due to
an erroneous thermal sensor reading, or when somebody
loses their CPU fan; and it is the exact same path
that the system would take if somebody booted with acpi=off.

> Also notice that thermal.c is so "interestingly" written that my patch
> does not actually make it longer by deleting useless defines etc...

Conserving syntax is certainly laudable,
but conserving semantics is even more valuable.

I do thank you for identifying this issue and
proposing change.

-Len


