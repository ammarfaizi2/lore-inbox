Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbTJTJ0U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 05:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbTJTJ0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 05:26:19 -0400
Received: from mailout.zma.compaq.com ([161.114.64.103]:39172 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S262467AbTJTJ0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 05:26:15 -0400
Date: Mon, 20 Oct 2003 11:24:45 +0200
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Tomas Szepe <szepe@pinerecords.com>,
       Torben Mathiasen <torben.mathiasen@hp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] fix ServerWorks PIO auto-tuning
Message-ID: <20031020092445.GB1685@tmathiasen>
References: <200310162344.09021.bzolnier@elka.pw.edu.pl> <20031018130234.GA28095@louise.pinerecords.com> <200310181745.41768.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310181745.41768.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
X-OS: Linux 2.4.22 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18 2003, Bartlomiej Zolnierkiewicz wrote:
> 
> We depend on BIOS hints for ServerWorks and BIOS is not enabling DMA.
> AFAIR we can't force DMA in this case because there are broken hardware
> designs, so current behavior is safe.  However more research is needed...
>

On a Proliant, DMA may or may not be supported on different devices, and the
BIOS knows about it. So by letting it hint its setup, we have a safe way of
configuring the chipset. The 'biostimings' code used a similar approach (by
leaving the BIOS setup timings alone), but as you also reported, was so generic
that it could be dangerous for other chipsets.

So if you have a Proliant where you get DMA enabled and it fails, it has to be
a BIOS bug (since the BIOS hintet DMA), and I'd like to know about it. OTOH, if
you have to explicitly enable DMA using hdparm, it may not be supported (since
the BIOS hinted pio). 


BTW Tomas, that drive you're adding to your ML350G2, is that just to have a spare IDE
disk drive? IIRC, the 350 is a SCSI system with only an ATAPI cdrom drive. But
I could be wrong.

Thanks,
Torben
