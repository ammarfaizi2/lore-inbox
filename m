Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266930AbSKUXYT>; Thu, 21 Nov 2002 18:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbSKUXYT>; Thu, 21 Nov 2002 18:24:19 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:63367 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S266930AbSKUXYR>; Thu, 21 Nov 2002 18:24:17 -0500
Date: Fri, 22 Nov 2002 00:31:19 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Andy Grover <agrover@groveronline.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow others to use ACPI EC interface
Message-ID: <20021121233119.GA909@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Andy Grover <agrover@groveronline.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0211201949450.23016-100000@dexter.groveronline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211201949450.23016-100000@dexter.groveronline.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 08:00:13PM -0800, Andy Grover wrote:

> Hi Stelian,

Hi. Sorry for replying so late.

> Do you have a system that works with ACPI?

Yes, My C1VE Vaio works well with the latest ACPI.

> This patch against 2.5.latest adds externally callable ec_read and
> ec_write functions to the ACPI EC driver. Calling these should allow the
> sonypi driver to avoid EC contention when ACPI is present.

Great. I've tested it and it works great here (I've modified sonypi
to use ec_read/write instead of the homebrew replacements). Feel free
to push the patch to Linus and I'll submit my modifications after that
(I have a quite large update pending for the sonypi driver, so I'll
submit all this probably this weekend).

> Unfortunately I don't think sonypi will be able to remove its own EC read 
> and write functions, for the non-ACPI case.

I have no problem with that.

> Comments?

Well, not directly related to the EC thing but rather to the ACPI/sonypi
integration, but maybe you noticed that the sonypi driver also
re-implements some code which is originally defined in the ACPI bios
(SRS, DIS methods on "SPIC" ACPI object). 

One day I should really call some ACPI exported function to do this,
but last time I looked at this (3 months ago ?), the ACPI API (the one
exported to external users) was still changing each day. 

Have things improved in this area ? 

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
