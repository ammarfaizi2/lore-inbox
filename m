Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267663AbUHEM3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267663AbUHEM3Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 08:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267669AbUHEM3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 08:29:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:16585 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267663AbUHEM3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 08:29:24 -0400
Date: Thu, 5 Aug 2004 14:29:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: kernel@wildsau.enemy.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040805122907.GI11159@suse.de>
References: <200408051225.i75CPT4U004434@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408051225.i75CPT4U004434@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05 2004, Joerg Schilling wrote:
> >From: Jens Axboe <axboe@suse.de>
> 
> >ATA method is misnamed, it's really SG_IO that is used. And you want to
> >use that regardless of the device type, SCSI or ATAPI. There's no such
> >thing as an ATA burner, and there's no need to differentiate between
> >SCSI or ATAPI CD-ROM's when burning - SG_IO is the method to use. So
> >forget browsing /proc/ide and other hacks.
> 
> I am sorry but as Linux already has 6 different interfaces for sending 
> Generic SCSI commands and thus, we are running out of names.
> 
> Let me give you an advise: consolidate Linux so that is does only need
> /dev/sg and fix the bugs in ide-scsi instead of constantly inventing new
> unneeded interfaces.

That's been the general direction for quite some time, just that SG_IO
is the preferred method since that works all around. You were the one
that merged support for the CDROM_SEND_PACKET interface, which has
_never_ been advertised as a way to burn CDs in Linux. I'd suggest you
remove that.

-- 
Jens Axboe

