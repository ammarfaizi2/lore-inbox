Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWBVIQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWBVIQS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 03:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWBVIQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 03:16:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20024 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932355AbWBVIQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 03:16:17 -0500
Date: Wed, 22 Feb 2006 09:16:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Lord <lkml@rtr.ca>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Ariel Garcia <garcia@iwr.fzk.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4 libata + AHCI patched for suspend fails on ICH6
Message-ID: <20060222081622.GM8852@suse.de>
References: <200602191958.38219.garcia@iwr.fzk.de> <20060219191859.GJ8852@suse.de> <Pine.LNX.4.58.0602210903260.8603@shark.he.net> <43FBA907.6040906@rtr.ca> <Pine.LNX.4.58.0602211603510.8603@shark.he.net> <43FBAC6B.6030604@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FBAC6B.6030604@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21 2006, Mark Lord wrote:
> Randy.Dunlap wrote:
> >
> >Thanks, good to have the continued feedback.
> >It is SATA, right?  The latest patchset also includes PATA ACPI
> >objects support (using libata), but it is missing a few calls
> >to the functions that do the real work during resume.
> >Will patch that this week also.
> 
> It's a PATA notebook drive, attached with some kind of hidden
> bridge chip, to an Intel 82801FBM SATA ICH6M.
> 
> libata thinks it is pure SATA.

Actually libata does know it's behind a bridge and limits it somewhat,
but beyond that it's pure SATA for all it cares about.

-- 
Jens Axboe

