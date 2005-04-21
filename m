Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVDUKJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVDUKJr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 06:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVDUKJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 06:09:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49580 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261250AbVDUKJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 06:09:35 -0400
Date: Thu, 21 Apr 2005 11:09:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] kill old EH constants
Message-ID: <20050421100933.GA19586@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org, Linux/m68k <linux-m68k@vger.kernel.org>
References: <200504210608.j3L682Br002585@hera.kernel.org> <Pine.LNX.4.62.0504211155440.13231@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504211155440.13231@numbat.sonytel.be>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 11:58:12AM +0200, Geert Uytterhoeven wrote:
> sun3_NCR5380.c still uses the following:
> 
>   - SCSI_ABORT_SUCCESS
>   - SCSI_ABORT_ERROR
>   - SCSI_ABORT_SNOOZE
>   - SCSI_ABORT_BUSY
>   - SCSI_ABORT_NOT_RUNNING
>   - SCSI_RESET_SUCCESS
>   - SCSI_RESET_BUS_RESET
> 
> causing the driver to fail to build in 2.6.12-rc3. What should I replace them
> by?

You must replace NCR5380_abort and NCR5380_bus_reset with real new-style
EH routines.  I'd suggest copying them from NCR5380.c or even better
scrapping sun3_NCR5380.c in favour of that one completely.

