Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265337AbUEZHf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbUEZHf7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 03:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265338AbUEZHf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 03:35:59 -0400
Received: from fmr11.intel.com ([192.55.52.31]:41950 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S265337AbUEZHf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 03:35:57 -0400
Subject: ACPI & 2.4 (Re: [BK PATCH] PCI Express patches for 2.4.27-pre3)
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Matthew Wilcox <willy@debian.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       "linux-pci@atrey.karlin.mff.cuni.cz" 
	<linux-pci@atrey.karlin.mff.cuni.cz>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FC676@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FC676@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1085556934.26254.132.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 May 2004 03:35:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the ACPI part to enable MMconfig was pretty small.
We parse a table in the standard way and set a global variable --
that's about it.

I submitted it to 2.4 for the sole purpose
to enable Greg to enable native PCIExpress.

I expect demand for this in 2.4 as the major distros'
enterprise releases are still 2.4 based and the hardware has
arrived...  Your call, Marcelo, if this is something to
solve in upstream 2.4 or something the distros need
to solve for themselves.  I recommend leaving the
small ACPI piece of the puzzle intact in either case.

On Tue, 2004-05-25 at 08:54, Marcelo Tosatti wrote:
> I've humbly asked Len to stop doing big updates
> whenever possible on the 
> v2.4 ACPI code, and do bugfixes only instead. Is that a pain in the
> ass for you, Len?    
> 
> I asked that because it is common to see new bugs introduced by an
> ACPI update, and you know that more than I do.

At one point I released to 2.4 first because that is where
the useful testing feedback was; and then released to 2.5
to make sure it didn't fall behind.

Then I released to 2.4 and 2.6 simultaneously b/c
I got quick feeback from both camps.

Now we're into the era where the release-early
release-often matra applies to 26 only (or maybe more 2.6-mm)
and 2.4 is in maintenance mode.

I would still like to send some significant ACPI patches to 24.
Yes, they're 100% bugfixes -- sometimes bugfixes touch
lots of files too...  But I'll do so only after the same
fix has been proven in 2.6 for a spell.

With some parts of ACPI, such as the ACPICA core interpreter
this is actually pretty low risk, because that part of
the kernel is identical between 2.4 and 2.6.  So if 2.6 works,
so will 2.4.

Of course this also depends on if 2.4 will be accepting anything.
I recall talk back about 2.4.25 about the end of the 2.4 line.
I generally only have time to read LKML messages directed to me
or if the word "ACPI" appears in the message, so I may have missed
the word 2.4.  What is the word?

thanks,
-Len


