Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUINVgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUINVgb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUINVer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 17:34:47 -0400
Received: from fmr10.intel.com ([192.55.52.30]:48620 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S266186AbUINV3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 17:29:49 -0400
Subject: Re: [ACPI Debug] String: Length 0x0F, "Entering RTMP()"
From: Len Brown <len.brown@intel.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20040914061641.GD2336@suse.de>
References: <20040914061641.GD2336@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1095197368.5430.8.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Sep 2004 17:29:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 02:16, Jens Axboe wrote:
> Hi,
> 
> 2.6.9-rc2 is throwing a lot of these errors on my system:
> 
> [ACPI Debug] String: Length 0x0F, "Entering RTMP()"
> [ACPI Debug] String: Length 0x0F, "Entering TIN2()"
> [ACPI Debug] String: Length 0x0F, "Existing RTMP()"
> 
> About 450 of these three lines repeated so far, seem to get one every
> 5
> seconds or so. Box is an Athlon64 solo, let me know if you want more
> info (and what).
> 
> --
> Jens Axboe

These are due to debug statements in your BIOS AML code.
The Linux AML interpreter recognizes them and sends
them to the console.

Start by checking that you're running a production BIOS.

echo 0 >/proc/acpi/debug_level should make them go away.

cheers,
-Len


