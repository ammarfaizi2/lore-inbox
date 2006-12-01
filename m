Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031750AbWLATei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031750AbWLATei (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031754AbWLATei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:34:38 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:1545 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1031750AbWLATeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:34:37 -0500
Date: Fri, 1 Dec 2006 19:34:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Scott Wood <scottwood@freescale.com>
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make platform_device_add_data accept a const pointer.
Message-ID: <20061201193428.GA4055@flint.arm.linux.org.uk>
Mail-Followup-To: Scott Wood <scottwood@freescale.com>, trivial@kernel.org,
	linux-kernel@vger.kernel.org
References: <20061201185447.GA19669@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201185447.GA19669@ld0162-tx32.am.freescale.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 12:54:47PM -0600, Scott Wood wrote:
> platform_device_add_data() makes a copy of the data that is given to it,
> and thus the parameter can be const.  This removes a warning when data
> from get_property() on powerpc is handed to platform_device_add_data(),
> as get_property() returns a const pointer.

Doesn't this cause a compile warning in platform.c, concerning assigning
'data' to struct device's non-const 'platform_data' pointer?

So in essence you're probably just moving the problem rather than really
solving anything.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
