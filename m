Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUIOGHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUIOGHt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 02:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUIOGHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 02:07:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25511 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264919AbUIOGHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 02:07:47 -0400
Date: Wed, 15 Sep 2004 08:06:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI Debug] String: Length 0x0F, "Entering RTMP()"
Message-ID: <20040915060615.GB2304@suse.de>
References: <20040914061641.GD2336@suse.de> <1095197368.5430.8.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095197368.5430.8.camel@d845pe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14 2004, Len Brown wrote:
> On Tue, 2004-09-14 at 02:16, Jens Axboe wrote:
> > Hi,
> > 
> > 2.6.9-rc2 is throwing a lot of these errors on my system:
> > 
> > [ACPI Debug] String: Length 0x0F, "Entering RTMP()"
> > [ACPI Debug] String: Length 0x0F, "Entering TIN2()"
> > [ACPI Debug] String: Length 0x0F, "Existing RTMP()"
> > 
> > About 450 of these three lines repeated so far, seem to get one every
> > 5
> > seconds or so. Box is an Athlon64 solo, let me know if you want more
> > info (and what).
> > 
> > --
> > Jens Axboe
> 
> These are due to debug statements in your BIOS AML code.
> The Linux AML interpreter recognizes them and sends
> them to the console.
> 
> Start by checking that you're running a production BIOS.

I'm not

> echo 0 >/proc/acpi/debug_level should make them go away.

Ah thanks, yes that works!

-- 
Jens Axboe

