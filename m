Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271497AbTGQRMW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 13:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271511AbTGQRMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 13:12:21 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:62393 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S271497AbTGQRMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 13:12:17 -0400
Date: Thu, 17 Jul 2003 18:26:25 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "Andrew S. Johnson" <andy@asjohnson.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DRM, radeon, and X 4.3
Message-ID: <20030717172625.GA16502@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Andrew S. Johnson" <andy@asjohnson.com>,
	linux-kernel@vger.kernel.org
References: <200307170539.25702.andy@asjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307170539.25702.andy@asjohnson.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 05:39:25AM -0500, Andrew S. Johnson wrote:
 > I start X but it says DRM is disabled, even though the
 > radeon and agpgart modules are loaded.  Here is the dmesg tail:
 > 
 > Linux agpgart interface v0.100 (c) Dave Jones
 > [drm] Initialized radeon 1.9.0 20020828 on minor 0
 > [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
 > [drm:radeon_unlock] *ERROR* Process 1929 using kernel context 0
 > 
 > There is something X doesn't like.  How do I fix this?

Looks like there isn't an agp chipset module also loaded
(via-agp.o, intel-agp.o etc...)

You should have additional text after the first AGP line.

		Dave
