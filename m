Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbTJPKg4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbTJPKg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:36:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26273 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262819AbTJPKgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:36:54 -0400
Date: Thu, 16 Oct 2003 12:36:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
Message-ID: <20031016103653.GN1128@suse.de>
References: <20031013140858.GU1107@suse.de> <20031013223911.GB14152@merlin.emma.line.org> <3F8B4048.2010007@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8B4048.2010007@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13 2003, Jeff Garzik wrote:
> Matthias Andree wrote:
> >On Mon, 13 Oct 2003, Jens Axboe wrote:
> >
> >
> >>Forward ported and tested today (with the dummy ext3 patch included),
> >>works for me. Some todo's left, but I thought I'd send it out to gauge
> >>interest. TODO:
> >>
> >>- Detect write cache setting and only issue SYNC_CACHE if write cache is
> >> enabled (not a biggy, all drives ship with it enabled)
> >
> >
> >Yup, and I disable it on all drives at boot time at the latest.
> >
> >Is there a status document that lists
> >
> >- what SCSI drivers support write barriers
> >  (I'm interested in sym53c8xx_2 if that matters)
> >
> >- what IDE drivers support write barriers
> >  (VIA for AMD and Intel for PII/PIII/P4 chip sets here)
> 
> The device is the entity that does, or does not, support flush-cache... 
>  All IDE chipsets support flush-cache... it's just another IDE command.

Well drivers need to support it, too. IDE is supported, and that covers
all devices that support it. It's not implemented on SCSI at all right
now, that's coming up.

-- 
Jens Axboe

