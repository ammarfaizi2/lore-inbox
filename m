Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbTJCUcB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 16:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbTJCUcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 16:32:01 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:39599 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261186AbTJCUb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 16:31:59 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Allen Martin <AMartin@nvidia.com>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH][IDE] small cleanup for AMD/nVidia IDE driver
Date: Fri, 3 Oct 2003 22:35:14 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F704@mail-sc-6.nvidia.com>
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F704@mail-sc-6.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310032235.14733.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 of October 2003 21:51, Allen Martin wrote:
> > I've seen 2.4.x patches from Allen Martin@nVidia on lkml.
> > In UDMA133 patch he mentioned that UDMA should be programmed by mode,
> > not UDMA cycle timing on nVidia chipsets (probably the same
> > applies to AMD).
> > Can you comment on this?
>
> Yes, these controllers have a 1:1 mapping between UDMA mode and
> AMD_UDMA_TIMING value.  Trying to map UDMA mode to cycle time and then map
> back to UDMA mode is error prone, and cause for some of the ugly
> workarounds in the current driver.  My patch to add Ultra133 support just
> expands this ugliness, but works.
>
> The mapping is as follows:
>
> UDMA2 0
> UDMA1 1
> UDMA0 2
> UDMA3 4
> UDMA4 5
> UDMA5 6
> UDMA6 7

Thanks for explaining this.
Vojtech please consider it in your future patches. ;-)

> Other ACPI aware OS'es use an ACPI method to change IDE timing, so this is
> hidden from the OS.

Damn, I must take a look at ACPI specification 8-).

--bartlomiej

