Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVHAIvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVHAIvv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 04:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVHAIvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 04:51:51 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:31374 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261720AbVHAIvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 04:51:37 -0400
To: "Brown, Len" <len.brown@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Hugh Dickins" <hugh@veritas.com>, "Andrew Morton" <akpm@osdl.org>,
       "Dominik Brodowski" <linux@dominikbrodowski.net>,
       "Daniel Ritz" <daniel.ritz@gmx.ch>, torvalds@osdl.org
Subject: Re: revert yenta free_irq on suspend
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com>
Date: Mon, 1 Aug 2005 09:51:27 +0100
Message-Id: <E1DzW19-0005hd-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown, Len <len.brown@intel.com> wrote:

> But that believe would be total fantasy -- supsend/resume is not
> working on a large number of machines, and no distro is currently
> able to support it.  (I'm talking about S3 suspend to RAM primarily,
> suspend to disk is less interesting -- though Red Hat doesn't
> even support _that_)

It's still failing on a large number of machines, but it's working on a
larger set. We (Ubuntu) shipped with suspend to RAM support in our
previous release. Frankly, at this stage the three biggest problems are:

a) resuming video (not going to be fixed in the ACPI core)
b) SATA resume (not going to be fixed in the ACPI core)
c) Motherboard chipsets that don't seem to be programmed to handle
memory refresh (not going to be fixed in the ACPI core)

People /do/ use this code, and breaking a large number of working setups
in order to fix a bug that appears on a small number of setups (and can
be worked around in a rather less invasive way) isn't sensible.
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
