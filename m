Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbTK3QZh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 11:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264935AbTK3QZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 11:25:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58269 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264934AbTK3QZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 11:25:35 -0500
Date: Sun, 30 Nov 2003 17:25:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "Prakash K. Cheemplavam" <prakashkc@gmx.de>,
       Jeff Garzik <jgarzik@pobox.com>, marcush@onlinehome.de,
       linux-kernel@vger.kernel.org
Subject: Re: Silicon Image 3112A SATA trouble
Message-ID: <20031130162523.GV10679@suse.de>
References: <3FC36057.40108@gmx.de> <200311301547.32347.bzolnier@elka.pw.edu.pl> <3FCA1220.2040508@gmx.de> <200311301721.41812.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311301721.41812.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30 2003, Bartlomiej Zolnierkiewicz wrote:
> 
> I read it _very_ closely, here is your original mail with subject
> "Re: 2.6.0-test9 /-mm3 SATA siimage - bad disk performance":
> 
> On Saturday 15 of November 2003 10:11, Prakash K. Cheemplavam wrote:
> > Marcus Hartig wrote:
> > > Hello all,
> > >
> > > with the Fedora 1 kernel 2.4.22-1.2115.nptl I get with hdparm -t
> > > (Timing buffered disk reads) 34 MB/sec. Its very slow for this drive.
> > >
> > > With 2.6.0-test9 and -mm3 I get around "62 MB in 3.05 = 20,31". Wow"
> > > Back to ~1998?
> >
> > I have a similar problem: With 2.4.22-ac3 I had 37mb/sec with my Samsung
> > HD and 49MB/sec with IBM/Hitachi, now with 2.6 (all I tried, including
>                                     ^^^^^^^^^^^^
> > test9-mm2) I had only 20mb/sec for Samsung and about 39mb/sec for the
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > IBM. Motherboard is Abit NF7-S Rev2.0, as well, so same situation with
>   ^^^^
> > the siimage 1.06 driver. I wanted to run some dd tests as well, but it 
> > is a real performance hit. Playing with readahead or other hdparm
> > options didn't help either.
> >
> > Prakash
> 
> In 2.6.x there is no max_kb_per_request setting in /proc/ide/hdx/settings.
> Therefore
> 	echo "max_kb_per_request:128" > /proc/ide/hde/settings
> does not work.
> 
> Hmm. actually I was under influence that we have generic ioctls in 2.6.x,
> but I can find only BLKSECTGET, BLKSECTSET was somehow lost.  Jens?

Probably because it's very dangerous to expose, echo something too big
and watch your data disappear.

-- 
Jens Axboe

