Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVBOPIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVBOPIC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 10:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVBOPHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 10:07:41 -0500
Received: from fmr13.intel.com ([192.55.52.67]:40403 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261746AbVBOPF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 10:05:57 -0500
Subject: Re: [ACPI] [PATCH] Panasonic ACPI driver
From: Len Brown <len.brown@intel.com>
To: Timo Hoenig <thoenig@suse.de>
Cc: linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1108066047.32630.5.camel@nouse.net>
References: <1108066047.32630.5.camel@nouse.net>
Content-Type: text/plain
Organization: 
Message-Id: <1108479925.2098.35.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 15 Feb 2005 10:05:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We should not include this driver in the kernel.

Rather than adding additional platform-specific drivers,
we should be migrating away from those that we already have
to simpler generic drivers for video and hot-keys -- where
the platform-dependent (naming) is done in user-space where
it is more extensible and supportable.

We've already got video.c, and I believe that we should start
to migrate to something like Luming's hot-key driver (see
earlier acpi-devel posts) in 2.6.12.

If a platform has some unique feature that no other platform
in the world has, then that justifies a platform specific driver
for that unique feature.  But for the common features, the
community will be better served by the simpler generic kernel
drivers that work on more systems.

thanks,
-Len


