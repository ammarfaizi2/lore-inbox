Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751745AbWE1Ida@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbWE1Ida (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 04:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWE1Id3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 04:33:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10645 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751529AbWE1Id2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 04:33:28 -0400
Subject: Re: DMA errors, then I/O errors, on 2.6.16
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Moise <chops@demiurgestudios.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060527210715.GA2866@qix.demiurgestudios.com>
References: <20060527210715.GA2866@qix.demiurgestudios.com>
Content-Type: text/plain
Date: Sun, 28 May 2006 10:33:23 +0200
Message-Id: <1148805203.3074.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-27 at 17:07 -0400, Andrew Moise wrote:
>   Running 2.6.16 (and some earlier 2.6 kernels as well), I get
> occasional DMA failures, which are always followed by the disk not
> working at all (any request leads to an I/O error).  The log and whatnot
> follows.  Can anyone tell me what the source of this trouble might be
> (disk, controller, cable, software)?
>   Please CC replies to me, as I'm not on the list.  Thanks.
> 
> --- Log:
> 
> May 27 16:34:44 vino kernel: hda: dma_intr: status=0x7f { DriveReady DeviceFault
>  SeekComplete DataRequest CorrectedError Index Error } 
> May 27 16:34:44 vino kernel: hda: dma_intr: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=1495
> 68083689343, high=8914952, low=8355711, sector=356876123 


this tends to be a disk dying.. better run smartctl to check it out...

