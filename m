Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTEMSCB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTEMSB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:01:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58277 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263375AbTEMSA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:00:59 -0400
Date: Tue, 13 May 2003 20:13:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       "Mudama, Eric" <eric_mudama@maxtor.com>,
       Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030513181337.GM17033@suse.de>
References: <785F348679A4D5119A0C009027DE33C102E0D31D@mcoexc04.mlm.maxtor.com> <20030512193509.GB10089@gtf.org> <20030512194245.GG17033@suse.de> <20030512195331.GD10089@gtf.org> <20030513064059.GL17033@suse.de> <20030513180020.GB3309@suse.de> <20030513180334.GJ17033@suse.de> <20030513180459.GB11073@gtf.org> <20030513180651.GK17033@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513180651.GK17033@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13 2003, Jens Axboe wrote:
> On Tue, May 13 2003, Jeff Garzik wrote:
> > On Tue, May 13, 2003 at 08:03:34PM +0200, Jens Axboe wrote:
> > > On Tue, May 13 2003, Dave Jones wrote:
> > > > On Tue, May 13, 2003 at 08:40:59AM +0200, Jens Axboe wrote:
> > > >  > > Weird.  Mine doesn't seem to assert it, nor does the identify page
> > > >  > > indicate it's supported.  Maybe I have a broken drive firmware.
> > > >  > 
> > > >  > Then the linux code won't work on it, have you tried? I've tried a lot
> > > >  > of different IBM models, they all do service interrupts just fine.
> > > > 
> > > > bug in the firmware version on Jeffs drives perhaps ?
> > > 
> > > It's possible, it would help a lot of Jeff would answer the question
> > > above and maybe even share what drive he is using with us.
> > 
> > hehe, just did (answer: no).  I'll post hdparm -I for it tomorrow.
> 
> :) thanks! fwiw, I've tried DTLA, DPTA, and the IC vancouvers here.

btw, you may want to see the IDE_TCQ_FIDDLE_SI define in ide-tcq, here's
the comment I put there:

/*
 * we are leaving the SERVICE interrupt alone, IBM drives have it
 * on per default and it can't be turned off. Doesn't matter, this
 * is the sane config.
 */
#undef IDE_TCQ_FIDDLE_SI

Are you sure this isn't what you are seeing?

-- 
Jens Axboe

