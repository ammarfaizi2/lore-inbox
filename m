Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbTEGTTK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264227AbTEGTTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:19:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43415 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264235AbTEGTSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:18:24 -0400
Date: Wed, 7 May 2003 21:30:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
Message-ID: <20030507193058.GT823@suse.de>
References: <Pine.LNX.4.44.0305070915470.2726-100000@home.transmeta.com> <1052332148.3061.50.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052332148.3061.50.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07 2003, Alan Cox wrote:
> On Mer, 2003-05-07 at 17:28, Linus Torvalds wrote:
> > At least if I read the patch correctly, theer's no way for upper layers to
> > say "I want 48-bit addressing" - it's just turned on automatically for
> > high sectors (or big transfers).
> 
> You read it incorrectly. The lower layers don't know about the issue at
> all. The disk layer does mapping (conceptually like READ6/READ10/READ16
> in SCSI) 
> 
> Raw I/O and other drivers can still issue CHS LBA28 and LBA48 taskfiles.
> 
> > Well, you can mark the drive itself as wanting 48-bit transfers, but you 
> > can't do it on a per-request basis.
> 
> Its per request at the low level.

Thanks Alan, that is exactly right of course.

Linus has one point (I'll give him that), in that it might be beneficial
to be able to say "48-bit always on" for fs requests. Ie exactly what
ide-disk currently does.

-- 
Jens Axboe

