Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUHDM6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUHDM6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 08:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbUHDM6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 08:58:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3804 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265196AbUHDM6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 08:58:31 -0400
Date: Wed, 4 Aug 2004 14:58:18 +0200
From: Jens Axboe <axboe@suse.de>
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>
Cc: linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040804125818.GM10340@suse.de>
References: <200408041233.i74CX93f009939@wildsau.enemy.org> <20040804124335.GK10340@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040804124335.GK10340@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04 2004, Jens Axboe wrote:
> > + * Sat Jun 12 12:48:12 CEST 2004 herp - Herbert Rosmanith
> > + *     Force ATAPI driver if dev= starts with /dev/hd and device
> > + *     is present in /proc/ide/hdX
> > + *
> 
> That's an extremely bad idea, you want to force ATA driver in either
> case.

Which, happily, is what already happens and why it works fine when you
just do -dev=/dev/hdX. What should be removed is the warning that
cdrecord spits out when you do this, and the whole ATAPI thing should
just mirror ATA and scsi-linux-ata be killed completely.

So I suggest you do that instead and send it to Joerg, cdrecord/cdrtool
patches are off topic here.

-- 
Jens Axboe

