Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264407AbTFQRtJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 13:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTFQRtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 13:49:09 -0400
Received: from [213.24.247.63] ([213.24.247.63]:7609 "EHLO
	mail.techsupp.relex.ru") by vger.kernel.org with ESMTP
	id S264407AbTFQRtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 13:49:06 -0400
From: Yaroslav Rastrigin <yarick@relex.ru>
Organization: RELEX Inc.
To: "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: ACPI broken... again!
Date: Tue, 17 Jun 2003 22:02:47 +0400
User-Agent: KMail/1.5.1
References: <F760B14C9561B941B89469F59BA3A84725A2F1@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A2F1@orsmsx401.jf.intel.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306172202.47579.yarick@relex.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
> "Again." Are you saying it used to work on these machines and then it
> stopped? If so I think we have a fix to try in the next ACPI release
> (which may or may not make it into the next kernel release.)
Well, I, for myself, didn't needed ACPI for my desktops/servers - they 
were/are working fine without it. When I've dumped processing power for 
mobility, however - as much power management as possible is (almost) a 
requirement (for me). How/where could I find your fix to test (yes, I'm 
reading acpi-devel, but installing bitkeeper to pull these 'assorted fixes' 
is somewhat like an overkill. Diff ?)
>
> > The symptom is that eth0 does not see the others.
> > /proc/interrupts has
> > the correct interrupt listed, so it took me a while to suspect ACPI.
> > agpgart also crashes, and firewire and USB didn't find any devices.
> >
> > Why oh why is ACPI so horrendously broken?
>
> Do I hear violins playing? Poor, poor you! :)
If only he was alone...
>
> The ACPI PCI routing code still isn't 100% correct. Have you tried
> pci=noacpi? Have you diagnosed exactly what is going wrong on your
Yes. Doesn't helps (well, my particular problem is miniPCI 3c556 fails to be 
detected properly with ACPI enabled. Seems base io addr is detected 
incorrectly, and subsequent calls to read data return 0xFF instead of actual 
values. I've posted message here few days ago, and I didn't intend to repost 
it, but this discussion took me by heart.).
> system? Have you checked bugzilla for similar bugs? Have you sent a
Yes. Nothing similar (I'm wondering if ThinkPad T2x series are so unpopular 
among linux users/developers, and nobody stepped on this bug before, or I'm 
so very special...).
> > patch fixing the problem on your system?
Well, 3c59x driver source is 100K of tightly hardware-bound code (as almost 
every other driver). Looks I'll need another three or four months just to 
grok what's happening there - I'm not a Donald Becker (:-)
>
> So don't compile it in for now. When you buy a system in a few years
> that won't work properly without ACPI, and it *works* because of the
> work everyone on acpi-devel is doing, then you'll change your tune.
Well. Probably. Is there some kind of ACPI HCL ?

-- 
With all the best, yarick at relex dot ru.

