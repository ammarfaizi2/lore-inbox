Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317963AbSGLBSD>; Thu, 11 Jul 2002 21:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317964AbSGLBSC>; Thu, 11 Jul 2002 21:18:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45327 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317963AbSGLBSB>; Thu, 11 Jul 2002 21:18:01 -0400
Subject: Re: IDE/ATAPI in 2.5
To: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 12 Jul 2002 02:00:08 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <agl7ov$p91$1@cesium.transmeta.com> from "H. Peter Anvin" at Jul 11, 2002 05:27:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17Son2-0001yp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please consider deprecating or removing ide-floppy/ide-tape/ide-cdrom
> and treat all ATAPI devices as what they really are -- SCSI over IDE.

They aren't.

o	Not all ide cdrom devices are ATAPI capable
o	Many ide floppy devices can do ATAPI but get it horribly wrong
o	ide-tape is -totally- weird and unrelated to st

Andre did the framework ready to move to a situation where you could open
either the ide-scsi or the ide-cdrom name without module reloading mess.
You'd need to ask our new 2.5 IDE maintainer to finish that work off.

For disk it gets much easier. Linus has already said he wants a single
'disk' device, which once we get 32bit dev_t will be nice. With that we
can finally turn aacraid, megaraid and other 'fake scsi' devices back to
raw block devices without breaking compatibility assumptions, and get more
throughput.

Alan


