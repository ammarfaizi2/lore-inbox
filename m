Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbTELSq4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbTELSq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:46:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17307 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262548AbTELSqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 14:46:55 -0400
Date: Mon, 12 May 2003 20:59:34 +0200
From: Jens Axboe <axboe@suse.de>
To: "Mudama, Eric" <eric_mudama@maxtor.com>
Cc: Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030512185934.GD17033@suse.de>
References: <785F348679A4D5119A0C009027DE33C102E0D31A@mcoexc04.mlm.maxtor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785F348679A4D5119A0C009027DE33C102E0D31A@mcoexc04.mlm.maxtor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12 2003, Mudama, Eric wrote:
> 
> The only difference between SATA TCQ and PATA TCQ is that in PATA TCQ, the
> drive doesn't report the active tag bitmap back to the host after each
> command.  Other than that they are functionally identical to my
> understanding.  (Yes, there are options like first-party DMA, but these are
> not requirements)

You are ignoring the host side of things. PATA TCQ is basically
unsupportable without some hardware support (auto-poll). It's my
understanding that all SATA controllers do that.

Then there's the debate of whether TCQ is worth it at all, in general. I
feel that a few tags just to minimize the time spent when ending a
request to starting a new one is nice.

> Personally I'd like to see the option stay in there as experimental, it
> helps us drive folks test stuff when we can just flip an option off/on to
> get that functionality.

I agree, besides it just needs a bit of fixing, can't be much.

-- 
Jens Axboe

