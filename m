Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbTLBSrB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTLBSrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:47:01 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:5137
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264278AbTLBSq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:46:58 -0500
Date: Tue, 2 Dec 2003 10:46:48 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg Stark <gsstark@mit.edu>, Erik Steffl <steffl@bigfoot.com>,
       linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
Message-ID: <20031202184648.GU1566@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Greg Stark <gsstark@mit.edu>, Erik Steffl <steffl@bigfoot.com>,
	linux-kernel@vger.kernel.org
References: <3FCB8312.3050703@rackable.com> <87fzg4ckej.fsf@stark.dyndns.tv> <3FCBB15F.7050505@rackable.com> <3FCBB9F1.2080300@bigfoot.com> <87n0abbx2k.fsf@stark.dyndns.tv> <20031202055336.GO1566@mis-mike-wstn.matchmail.com> <20031202055852.GP1566@mis-mike-wstn.matchmail.com> <87zneb9o5q.fsf@stark.dyndns.tv> <20031202174048.GQ1566@mis-mike-wstn.matchmail.com> <20031202180458.GC1990@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031202180458.GC1990@gtf.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 01:04:58PM -0500, Jeff Garzik wrote:
> On Tue, Dec 02, 2003 at 09:40:48AM -0800, Mike Fedyk wrote:
> > There are PATA drives that do TCQ too, but you have to look for that feature
> > specifically.  IDE TCQ is in 2.6, but is still experemental.  I think Jens
> > Axboe was the one working on it IIRC.  He would have more details.
> 
> Let us distinguish three types of TCQ:
> 1) PATA drive-side TCQ (now called "legacy TCQ")
> 2) Controller-side TCQ
> 3) SATA drive/controller-side TCQ ("first party DMA")
> 
> libata will never support #1, which is what 2.6 supports in experimental
> option.

An experemental option with the ide layer, not libata, right?

> 
> libata will support #2 very soon, and will support #3 when hardware is
> available.
> 

If you have Controller-side TCQ, then will it work with any IDE PATA/SATA
drive?

> > > Do the new SATA drives and controllers provide a solution to this?
> > 
> > It's not SATA specific, and I'm not sure if any ide controller can support
> > TCQ or if only a specific list are compatible.
> 
> The TCQ you are thinking of has been deprecated by the people who make
> IDE drives ;-)

Ahh, it's good to know that our TCQ support isn't lagging.  We're even
supporting TCQ standards that were only in place for 1 or 2 years. :)
