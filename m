Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbTEGTPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264212AbTEGTPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:15:15 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13445
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264192AbTEGTPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:15:14 -0400
Subject: Re: [PATCH] 2.5 ide 48-bit usage
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305070915470.2726-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305070915470.2726-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052332148.3061.50.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 May 2003 19:29:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-05-07 at 17:28, Linus Torvalds wrote:
> At least if I read the patch correctly, theer's no way for upper layers to
> say "I want 48-bit addressing" - it's just turned on automatically for
> high sectors (or big transfers).

You read it incorrectly. The lower layers don't know about the issue at
all. The disk layer does mapping (conceptually like READ6/READ10/READ16
in SCSI) 

Raw I/O and other drivers can still issue CHS LBA28 and LBA48 taskfiles.

> Well, you can mark the drive itself as wanting 48-bit transfers, but you 
> can't do it on a per-request basis.

Its per request at the low level.

