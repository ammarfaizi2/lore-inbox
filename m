Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272465AbTGaMF1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 08:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272467AbTGaMF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 08:05:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:42917 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S272465AbTGaMFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 08:05:22 -0400
Date: Thu, 31 Jul 2003 14:05:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Lou Langholtz <ldl@aros.net>
Cc: Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2+ext3+dbench=Buffer I/O error
Message-ID: <20030731120512.GQ22104@suse.de>
References: <5.2.1.1.2.20030730163933.00b41b50@wen-online.de> <20030730150902.5281f72c.akpm@osdl.org> <3F284CE6.6080701@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F284CE6.6080701@aros.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30 2003, Lou Langholtz wrote:
> Andrew Morton wrote:
> 
> >Mike Galbraith <efault@gmx.de> wrote:
> > 
> >
> >>Greetings,
> >>
> >>While trying to duplicate Randy Hron's "dbench has intermittent hang on 
> >>2.6.0-test1-ac2" report, I received quite a few "Buffer I/O error on 
> >>/dev/hda8, logical block N" messages.  (changing elevators makes no 
> >>difference fwiw).
> >>   
> >>
> >
> >That's just a gremlinlet.  You can delete the offending printk for now.
> >
> > 
> >
> >>I went back to test1, and it spat up a couple of "buffer 
> >>layer error" messages and associated traces.   Attempting to umount 
> >>afterward to run fsck left umount in D state.  See attachment.
> >>   
> >>
> >
> >Well that's a worry.  Is it repeatable? . . .
> >
> Any chance this problem is a consequence of not yet having Sean 
> Estabrooks partial bvec patch in this person's kernel??? 
> <http://www.ussg.iu.edu/hypermail/linux/kernel/0307.3/0861.html>. Jens 
> said he applied it on 2003/7/27 so it doesn't seem like this could have 
> made it into 2.6.0-test1-ac2.

no not unless Mike is using taskfile + pio, and even then I've never
heard of it triggering.

-- 
Jens Axboe

