Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbVCDFLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVCDFLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVCDFD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 00:03:59 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:62183 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S262149AbVCDEex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 23:34:53 -0500
Date: Fri, 4 Mar 2005 15:33:40 +1100
From: CaT <cat@zip.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE locking (was: Re: RFD: Kernel release numbering)
Message-ID: <20050304043340.GH30616@zip.com.au>
References: <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com> <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <42274171.3030702@nortel.com> <20050303165940.GA11144@kroah.com> <1109893901.21780.68.camel@localhost.localdomain> <20050304001930.GF30616@zip.com.au> <1109897041.21781.75.camel@localhost.localdomain> <20050304014415.GG30616@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304014415.GG30616@zip.com.au>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 12:44:16PM +1100, CaT wrote:
> The problems were weird. The fs I was copying from decided it was
> corrupt. Unmounting the partition and trying an fsck reported that it
> couldn't find the partition. After a reboot all was well and a fsck
> reported no problems.

Similar stuff with ac12 if dma is on on both drives.

Mar  4 15:15:55 nessie kernel: hdi: dma_timer_expiry: dma status == 0x21
Mar  4 15:16:10 nessie kernel: hdi: DMA timeout error
Mar  4 15:16:10 nessie kernel: hdi: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
Mar  4 15:16:10 nessie kernel:
Mar  4 15:16:10 nessie kernel: ide: failed opcode was: unknown

Should be noted that hdi does not boot with multisec or dma on.

-- 
    Red herrings strewn hither and yon.
