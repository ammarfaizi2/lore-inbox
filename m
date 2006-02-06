Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWBFEc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWBFEc6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 23:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWBFEc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 23:32:58 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:14828 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750965AbWBFEc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 23:32:57 -0500
Subject: Re: DMA in PCI chipset -- module vs. compiled-in
From: Lee Revell <rlrevell@joe-job.com>
To: William Park <opengeometry@yahoo.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060206034312.GA2962@node1.opengeometry.net>
References: <20060206034312.GA2962@node1.opengeometry.net>
Content-Type: text/plain
Date: Sun, 05 Feb 2006 23:32:51 -0500
Message-Id: <1139200372.2791.208.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-05 at 22:43 -0500, William Park wrote:
> But, for experiment, I tried compiling in only the "generic" options,
> and moved all specific PCI chipsets as modules.  Hotplug loads the
> modules, but with all 'hdparm' options turned off.  When I tried turning
> on DMA, 

Generic and chipset specific support are not complementary, they are
mutually exclusive.  Having generic PCI IDE support enabled will prevent
the chipset specific support from working properly.

This is actually a problem in several areas of the kernel (it's the same
for "Generic RTC" vs. the normal RTC) - I don't think the name "Generic"
properly reflects that it will prevent more specific device support from
working.

Lee

