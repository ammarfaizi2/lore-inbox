Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWALExc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWALExc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWALExc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:53:32 -0500
Received: from colo.lackof.org ([198.49.126.79]:56977 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S965014AbWALExb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:53:31 -0500
Date: Wed, 11 Jan 2006 22:02:43 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Mark Maule <maule@sgi.com>
Cc: linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>, gregkh@suse.de
Subject: Re: [PATCH 1/3] msi vector targeting abstractions
Message-ID: <20060112050243.GC332@colo.lackof.org>
References: <20060111155251.12460.71269.12163@attica.americas.sgi.com> <20060111155256.12460.26048.32596@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111155256.12460.26048.32596@attica.americas.sgi.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 09:52:56AM -0600, Mark Maule wrote:
> Abstract portions of the MSI core for platforms that do not use standard
> APIC interrupt controllers.  This is implemented through a new arch-specific
> msi setup routine, and a set of msi ops which can be set on a per platform
> basis.
...
> Index: linux-maule/drivers/pci/msi.c
...
> +	if ((status = msi_arch_init()) < 0) {

Willy told me I should always complain about assignment in if() statements :)

Greg, I volunteer to submit a patch to fix all occurances in pci/msi.c
including the one above.  I can prepare that this weekend on my own time.
Is that ok?

grant
