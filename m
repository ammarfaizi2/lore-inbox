Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbTELTcO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 15:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbTELTcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 15:32:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25255 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262525AbTELTbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 15:31:50 -0400
Date: Mon, 12 May 2003 21:44:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Mudama, Eric" <eric_mudama@maxtor.com>, Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030512194426.GH17033@suse.de>
References: <785F348679A4D5119A0C009027DE33C102E0D31D@mcoexc04.mlm.maxtor.com> <20030512193509.GB10089@gtf.org> <20030512194245.GG17033@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512194245.GG17033@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12 2003, Jens Axboe wrote:
> > Coming from an OS perspective, I think we really want to be able to
> > queue up a bunch of scatterlists, like the new AHCI spec does.
> 
> I have to agree with Eric that the largest win is potentially not
> getting hit by the rotational latency all the time. I don't think you'll
> get much extra from actually having more than one active from the dma
> POV.

Actually, thinking a bit about it, if you could have more than one
active command then the release interrupt gets more interesting.

I've been brain damaged from working on the current stuff. It's one
thing what the spec tells you, it's another what really works in reality
:/

-- 
Jens Axboe

