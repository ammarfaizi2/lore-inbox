Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268867AbUHLWyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268867AbUHLWyL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268866AbUHLWyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:54:10 -0400
Received: from fmr02.intel.com ([192.55.52.25]:41929 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S268864AbUHLWve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:51:34 -0400
Subject: Re: Allow userspace do something special on overtemp
From: Len Brown <len.brown@intel.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Dax Kelson <dax@gurulabs.com>, trenn@suse.de, seife@suse.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040812202401.GB14556@elf.ucw.cz>
References: <20040811085326.GA11765@elf.ucw.cz>
	 <1092269309.3948.57.camel@mentorng.gurulabs.com>
	 <1092281393.7765.141.camel@dhcppc4> <20040812074002.GC29466@elf.ucw.cz>
	 <1092320883.5021.173.camel@dhcppc4>  <20040812202401.GB14556@elf.ucw.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1092351080.5021.198.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 12 Aug 2004 18:51:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 16:24, Pavel Machek wrote:
> Hi!
> 
> > > > I think I'd rather see the calls to usermode deleted
> > > > instead of extended -- unless there is a reason that
> > > > the general event -> acpid method can't work.
> > > 
> > > See above, switching to acpid would break all the existing
> > > setups... in stable series.
> > 
> > ah, the price of progress.
> > 
> > I'm confident that the distros can figure out how to
> > update the (neglected) acpid scripts at the same time as
> > (or before) the kernel update.
> 
> * not everyone is running distro
> 
> * people update their kernels more often then their distros
> 
> * not everyone wants to run acpid or equivalent (I don't, for example)
> 
> * it is still change in stable series.

> * it is pretty subtle change, you are not going to notice it is broken
> unless you actually run critical.
> 
> > If they can't, then ACPI critical shutdown will fail
> > (maybe on some systems not such a bad thing;-)
> > and TM1 will kick in, and if that doesn't work, TM2
> > will kick in, and if that doesn't work the processor
> > will disable itself.
> 
> hmm, yes, but it still would be nice to properly shutdown instead of
> fail.

The reality is that most of the critical temperature events
are false positives, and for those that are not, the hardware
will keep itself from burning even when the OS control fails.

If we confuse some self-supporting kernel types, that is too bad.
If they're supporting themselves, they should read the change logs
for the kernels that they download.  I don't think
this is of a magnitude that it needs to wait for 2.7 to be fixed.

-Len


