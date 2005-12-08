Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVLHWVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVLHWVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbVLHWVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:21:24 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:56193 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932322AbVLHWVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:21:23 -0500
Subject: RE: [ACPI] ACPI owner_id limit too low
From: Alex Williamson <alex.williamson@hp.com>
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E03A96856@orsmsx403.amr.corp.intel.com>
References: <971FCB6690CD0E4898387DBF7552B90E03A96856@orsmsx403.amr.corp.intel.com>
Content-Type: text/plain
Organization: LOSL
Date: Thu, 08 Dec 2005 15:21:10 -0700
Message-Id: <1134080471.2476.9.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 14:03 -0800, Moore, Robert wrote: 
> We have increased the number of owner IDs to 255 in the most recent
> version of ACPICA, 20051202. This should hit Linux soon.
> 
> Additionally, we plan to conserve OwnerIDs by not using them for tables
> that can never be unloaded, to be implemented in a future release.
> However, 255 Ids should be plenty for now.
> 
> Here is the text from the release memo:
> 
> Increased the number of available Owner Ids for namespace object
> tracking from 32 to 255. This should eliminate the OWNER_ID_LIMIT
> exceptions seen on some machines with a large number of ACPI tables
> (either static or dynamic).

Hi Bob,

   Sorry if I wasn't clear, I'm worried about what happens in the
interim.  The problem will be fixed in ACPICA 20051202, but we have at
least one, likely two stable kernels that will be tagged before that
ACPICA version hits the upstream kernel.  We can hit the owner_id limit
fairly easily on a few development systems.  How many stable kernels do
we want out in the wild with such a low owner_id limit?  Bumping it up
to 64, while not ideal, is sufficient for our current usage, and I think
the patch is trivial enough that it could be included quickly.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

