Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267199AbUBRRjc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 12:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267236AbUBRRjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 12:39:31 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:25100 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267199AbUBRRja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 12:39:30 -0500
Message-ID: <4033A33F.FF279C05@SteelEye.com>
Date: Wed, 18 Feb 2004 12:39:11 -0500
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nbd oops on unload.
References: <20040217224700.GE6242@redhat.com> <4032FF7D.55D9935B@SteelEye.com> <20040218071752.GB27190@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Wed, Feb 18 2004, Paul Clements wrote:
> > Dave Jones wrote:
> > >
> > > modprobe nbd ; rmmod nbd  was enough to reproduce this one..
> > > (2.6.3rc4)
> >
> > hmmm...I'll look into it...out of curiosity, are you using any "unusual"
> > kernel config options? I've done the same test myself many times and
> > have not seen any problems...
> 
> It looks like 'the usual' 'several devices sharing a queue' oops on
> unload.

Ahh, cleanup was being done in the wrong order.

Patch coming shortly...

--
Paul
