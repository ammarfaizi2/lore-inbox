Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVACR03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVACR03 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVACR0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:26:19 -0500
Received: from fmr15.intel.com ([192.55.52.69]:23021 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261515AbVACRZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:25:05 -0500
Subject: __iounmap: bad address c00f0000 (Re: 2.6.10-bk5)
From: Len Brown <len.brown@intel.com>
To: Michael Geithe <warpy@gmx.de>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200501030114.55399.warpy@gmx.de>
References: <200501030114.55399.warpy@gmx.de>
Content-Type: text/plain
Organization: 
Message-Id: <1104773076.18173.64.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 03 Jan 2005 12:24:36 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-02 at 19:14, Michael Geithe wrote:

> DMI 2.3 present.
> __iounmap: bad address c00f0000
> ACPI: RSDP (v000 AMI                                   ) @ 0x000fa380

Not and ACPI issue:-)

Looks like the warning is provoked by Al Viro's update to dmi_iterate().
Perhaps there is a conflict between dmi_table()'s bt_iounmap(),
and dmi_iterate()'s new iounmap() on the same address?

-Len


