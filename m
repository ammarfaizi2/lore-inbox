Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbTEFOAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263729AbTEFN7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:59:10 -0400
Received: from mail1.ewetel.de ([212.6.122.14]:60883 "EHLO mail1.ewetel.de")
	by vger.kernel.org with ESMTP id S263730AbTEFN6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:58:32 -0400
Date: Tue, 6 May 2003 16:10:55 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [IDE] trying to make MO drive work with ide-floppy/ide-cd
In-Reply-To: <Pine.LNX.4.44.0305061552520.1235-100000@neptune.local>
Message-ID: <Pine.LNX.4.44.0305061608050.959-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Pascal Schmidt wrote:

> I'll check if reading from the MO drive works with ide-cd under 2.4
> as well. If it does: what about a patch that makes ATAPI MO drives
> and CD writers behave the same on 2.4: read-only with native ide drivers,
> read-write with ide-scsi?

I can now confirm that using the MO drive read-only with 2.4 and ide-cd
also works fine.

Could we please have this patch included in the 2.4 IDE code to make
MO drives and CD writers behave the same?

--- linux-2.4/drivers/ide/ide-probe.c	Mon May  5 21:25:32 2003
+++ build/drivers/ide/ide-probe.c	Tue May  6 16:03:28 2003
@@ -222,6 +222,7 @@ static inline void do_identify (ide_driv
 				break;
 			case ide_optical:
 				printk ("OPTICAL");
+				type = ide_cdrom;
 				drive->removable = 1;
 				break;
 			default:

-- 
Ciao,
Pascal

