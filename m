Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266792AbUHCS2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266792AbUHCS2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 14:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUHCS2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 14:28:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18397 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266792AbUHCS2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 14:28:36 -0400
Date: Tue, 3 Aug 2004 15:08:21 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Richard Wohlstadter <rwohlsta@watson.wustl.edu>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: dma problems with Serverworks CSB5 chipset
Message-ID: <20040803180821.GB6265@logos.cnet>
References: <4107E4B3.6070904@watson.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4107E4B3.6070904@watson.wustl.edu>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 12:38:59PM -0500, Richard Wohlstadter wrote:
> Hello,
> 
> I have 200 servers in a cluster running vanilla kernel 2.4.26(not 
> tainted).  Under heavy I/O activity I have various servers completely 
> lose access to their IDE bus.  Logs show the same error every time:
> 
> hda: dma_timer_expiry: dma status == 0x61
> 
> The kernel resets the IDE bus at this point.  Sometimes things start 
> working again but mostly all ide access is lost and I have to reboot the 
> server.  The chipset is:
> 
>  00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
> 
> I have searched archives for problems with this chipset and I have seen 
> other users with this same issue, but no resolution to the problem.  Is 
> there a known problem with this chipset version or could there be some 
> issues still with the serverworks driver?  Any help would be much 
> appreciated.  Thanks.

Richard,

ServerWorks OSB4/5 chipsets are known to not work reliably with the Linux
IDE code. AFAIK its a hardware problem which we dont correctly work around.

Have you tried disabling DMA?

Bart and Alan are IDE experts, they can probably give you more useful
information.
