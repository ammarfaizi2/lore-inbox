Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbUAYTdL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 14:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUAYTdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 14:33:10 -0500
Received: from odpn1.odpn.net ([212.40.96.53]:15854 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S265227AbUAYTdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 14:33:07 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Linux 2.4.25-pre7 - no DRQ after issuing WRITE
References: <Pine.LNX.4.58L.0401231652020.19820@logos.cnet> <x6ptd8l7so@gzp>
	<Pine.LNX.4.58L.0401251714400.1311@logos.cnet>
From: "Gabor Z. Papp" <gzp@papp.hu>
Date: Sun, 25 Jan 2004 20:33:02 +0100
Message-ID: <x6oesrj029@gzp>
User-Agent: Gnus/5.1004 (Gnus v5.10.4)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Authenticated: gzp1 odpn1.odpn.net a3085bdc7b32ae4d7418f70f85f7cf5f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcelo Tosatti <marcelo.tosatti@cyclades.com>:

| > Here we go: http://gzp.odpn.net/tmp/linux-2.4.25-pre7/
| >
| > The "no DRQ after issuing WRITE" problem with 2 120GB Seagate

...

| I'm not IDE expert, but these errors look like hardware fault for me
| (Bartlomiej CCed).
| 
| What about 2.6 and older 2.4 kernels on the same hardware ?

Same kernel works fine in a non-sw-raid environment, when I can't
stress enough the harddisks to fail. When I boot NetBSD 1.6.1, I'm
able to read-write the disks nonstop without any error. Thats why I
think its not hw problem, but I would like to use Linux 2.4, so I'm
waiting for Bartlomiej.

| -------------
| Mounted devfs on /dev
| Freeing unused kernel memory: 116k freed
| hde: dma_timer_expiry: dma status == 0x21
| hdg: dma_timer_expiry: dma status == 0x21
| hde: error waiting for DMA
| hde: dma timeout retry: status=0x7f { DriveReady DeviceFault SeekComplete
| DataRequest CorrectedError Index Error }
| hde: dma timeout retry: error=0x7f { DriveStatusError UncorrectableError
| SectorIdNotFound TrackZeroNotFound AddrMarkNotFound },
| LBAsect=9343692930943, high=556927, low=8355711, sector=4352
| hde: DMA disabled
| hdg: error waiting for DMA
| hdg: dma timeout retry: status=0x58 { DriveReady SeekComplete DataRequest
| }
| hdg: status error: status=0x50 { DriveReady SeekComplete }
| hdg: no DRQ after issuing MULTWRITE
| hdg: status timeout: status=0xd0 { Busy }

