Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbTENHDY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 03:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTENHDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 03:03:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:44419 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262145AbTENHDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 03:03:20 -0400
Date: Wed, 14 May 2003 09:15:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       "Mudama, Eric" <eric_mudama@maxtor.com>,
       Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030514071558.GX17033@suse.de>
References: <20030512193509.GB10089@gtf.org> <20030512194245.GG17033@suse.de> <20030512195331.GD10089@gtf.org> <20030513064059.GL17033@suse.de> <20030513180020.GB3309@suse.de> <20030513180334.GJ17033@suse.de> <20030513180459.GB11073@gtf.org> <20030513180651.GK17033@suse.de> <20030513181337.GM17033@suse.de> <20030513184205.GC11073@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513184205.GC11073@gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13 2003, Jeff Garzik wrote:
> On Tue, May 13, 2003 at 08:13:37PM +0200, Jens Axboe wrote:
> > btw, you may want to see the IDE_TCQ_FIDDLE_SI define in ide-tcq, here's
> > the comment I put there:
> > 
> > /*
> >  * we are leaving the SERVICE interrupt alone, IBM drives have it
> >  * on per default and it can't be turned off. Doesn't matter, this
> >  * is the sane config.
> >  */
> > #undef IDE_TCQ_FIDDLE_SI
> > 
> > Are you sure this isn't what you are seeing?
> 
> 
> My information comes solely from IDENTIFY DEVICE...

Maybe you shouldn't trust that, then :-)

Seriously, I suppose it depends on the drive or maybe that IBM
interprets the bits differently. This puppy:

IC35L040AVVA07-0

says it doesn't support it either, but I can damn well assure you that
it does. What it doesn't support (like other IBM's) is trying to change
it, then it complains.

So I'd be willing to bet lots of money that you drive generates service
interrupts just fine. As I said, I've yet to see one that doesn't.

-- 
Jens Axboe

