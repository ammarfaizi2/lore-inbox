Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVATSl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVATSl0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVATSlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:41:05 -0500
Received: from fmr13.intel.com ([192.55.52.67]:29893 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261872AbVATSk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:40:28 -0500
Subject: Re: [RFC: 2.6 patch] i386: unexport acpi_strict
From: Len Brown <len.brown@intel.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050120181527.GF3174@stusta.de>
References: <20050120181527.GF3174@stusta.de>
Content-Type: text/plain
Organization: 
Message-Id: <1106246351.2395.11.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 Jan 2005 13:39:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-20 at 13:15, Adrian Bunk wrote:
> I haven't found any possible modular usage of acpi_strict.

I'd prefer to continue to export this flag if that isn't a burden.

The reason is that it is the only way we have to globally tell
the ACPI interpreter and all its (usually modularized) policy
drivers to allow or dis-allow support for platforms that openly
violate the ACPI spec.  (By default the flag is clear and is
set explicity with "acpi_strict")

While the ACPI modules in the tree at the moment don't use
this flag, there are other out-of-tree
modules on the way, and they may need it.

-Len


