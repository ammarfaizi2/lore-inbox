Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbUKFMEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUKFMEI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 07:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbUKFMEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 07:04:08 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:19721 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261368AbUKFMEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 07:04:04 -0500
Date: Sat, 6 Nov 2004 12:03:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Richard Waltham <richard@fars-robotics.net>,
       SUPPORT <support@4bridgeworks.com>, Thomas Babut <thomas@babut.net>,
       linux-kernel@vger.kernel.org, Linux SCSI <linux-scsi@vger.kernel.org>,
       groudier@free.fr
Subject: Re: Kernel 2.6.x hangs with Symbios Logic 53c1010 Ultra3 SCSI Ada pter
Message-ID: <20041106120358.GC23305@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <matthew@wil.cx>,
	Richard Waltham <richard@fars-robotics.net>,
	SUPPORT <support@4bridgeworks.com>, Thomas Babut <thomas@babut.net>,
	linux-kernel@vger.kernel.org,
	Linux SCSI <linux-scsi@vger.kernel.org>, groudier@free.fr
References: <D5169CBBC6369D4CBFFABD7905CC9D695D31@tehran.Fars-Robotics.local> <20041106035951.GC24690@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106035951.GC24690@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 03:59:51AM +0000, Matthew Wilcox wrote:
> On Sat, Nov 06, 2004 at 12:02:32AM -0000, Richard Waltham wrote:
> > Good as a backup but the original PPR capability is defined in
> > scan_scsi.c. Shouldn't scan_scsi.c take note of the bus mode and enable
> > PPR capabilities accordingly? This would then cover this issue for all
> > relevant LLDDs wouldn't it?
> 
> scan_scsi.c doesn't know what mode the bus is in.  scan_scsi.c doesn't
> even know whether the bus is SPI, FC, iSCSI, SAS or SATA.

And PPR only makes sense for SPI anyway.  An good argument why this
should move to the SPI transport class, which does know about SE vs HVD
vs LVD.

