Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUGBIaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUGBIaq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 04:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUGBIaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 04:30:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32147 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266511AbUGBIao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 04:30:44 -0400
Date: Fri, 2 Jul 2004 10:29:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>, Ed Tomlinson <edt@aei.ca>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-ID: <20040702082930.GN1114@suse.de>
References: <20040610164135.GA2230@bounceswoosh.org> <Pine.LNX.4.10.10406260118220.19080-100000@master.linux-ide.org> <20040628181835.GA14632@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628181835.GA14632@bounceswoosh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28 2004, Eric D. Mudama wrote:
> On Sat, Jun 26 at  1:31, Andre Hedrick wrote:
> >
> >Eric,
> >
> >There is no need for a new opcode.
> >The behavior is simple and trivial to support.
> >
> >If standard flush_cache/ext were to behave just like standard data_in
> >taskfile register setup, yet use a non_data command state machine it would
> >be done.
> >
> >Special case would be deal with LBA Zero and this would have to behave
> >like a complete device flush.  Since flushing sector zero is not generally
> >done ... well this would go into a design debate and it is not my issue
> >nor my desire to enter one today.
> >
> >28-bit would support max 256 sectors
> >48-bit would support max 65536 sectors
> >
> >Anyone could write this simple proposal to T13 for SATA and T10 for SAS.
> 
> True, that would work just as well.
> 
> But as you mention, it isn't necessarilly what people want or think
> they want or could actually use...

It would work, but it's still a lot nicer to not have to issue an extra
command to flush the range.

-- 
Jens Axboe

