Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVADWTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVADWTi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVADWTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:19:36 -0500
Received: from dialin-209-183-20-85.tor.primus.ca ([209.183.20.85]:8832 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S262376AbVADWQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:16:18 -0500
Date: Tue, 4 Jan 2005 17:16:00 -0500
From: William Park <opengeometry@yahoo.ca>
To: Daniel Drake <dsd@gentoo.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Wait and retry mounting root device
Message-ID: <20050104221600.GA2619@node1.opengeometry.net>
Mail-Followup-To: Daniel Drake <dsd@gentoo.org>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <41DA8DFC.4030801@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DA8DFC.4030801@gentoo.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 12:37:16PM +0000, Daniel Drake wrote:
> This is based a patch by William Park <opengeometry@yahoo.ca> included in
> 2.6.10-mm1, in order to fix booting from usb-storage devices which no longer
> make their partitions immediately available.
> 
> While William's patch fixed the situation where you boot from a "root=8:1"
> parameter (to correspond to /dev/sda1), it does not allow you to use
> "root=/dev/sda1" (which apparently worked in 2.6.9 and earlier), because
> the name-->dev_t discovery is done before the "retry" loop starts, and is
> not retried during the loop.
> 
> This patch, which replaces William's, solves the above problems.

It's funny...  Your patch does the opposite.  It works for
    root=/dev/sda1
from the kernel command line, but not from Lilo or 'root=8:1' on command
line. :-)

-- 
William Park <opengeometry@yahoo.ca>
Open Geometry Consulting, Toronto, Canada
Linux solution for data processing. 
