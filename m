Return-Path: <linux-kernel-owner+w=401wt.eu-S965045AbXADT6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbXADT6N (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbXADT6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:58:12 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:50907 "EHLO
	pfepc.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965045AbXADT6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:58:12 -0500
Subject: Re: BUG, 2.6.20-rc3 raid autodetection
From: Kasper Sandberg <lkml@metanurb.dk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e0701041107n5369edfdj2efc871de0fe7d24@mail.gmail.com>
References: <1167936465.6594.5.camel@localhost>
	 <58cb370e0701041107n5369edfdj2efc871de0fe7d24@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 20:57:57 +0100
Message-Id: <1167940677.8595.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-04 at 20:07 +0100, Bartlomiej Zolnierkiewicz wrote:
> On 1/4/07, Kasper Sandberg <lkml@metanurb.dk> wrote:
> > Hello.
> >
> > i just attempted to test .20-rc3-git4 on a box, which has 6 drives in
> > raid5. it uses raid autodetection, and 2 ide controllers (via and
> > promise 20269).
> >
> > there are two problems.
> >
> > first, and most importantly, it doesent autodetect, i attempted with
> > both the old ide drivers, and the new pata on libata drivers, the drives
> > appears to be found, but the raid autoassembling just doesent happen.
> >
> > this is .17, which works:
> > http://sh.nu/p/8001
> >
> > this is .20-rc3-git4 which doesent work, in pata-on-libata mode:
> > http://sh.nu/p/8000
> >
> > this is .20-rc3-git4 which doesent work, in old ide mode:
> > http://sh.nu/p/8002
> 
> For some reason IDE disk driver is not claiming IDE devices.
> 
> Could you please double check that IDE disk driver is built-in
> (CONFIG_BLK_DEV_IDEDISK=y in the kernel configuration)
> and not compiled as module?
i need not check even once, i do not have module support enabled, so
everything 1000000% surely is built in. this is the case for .17 too
(and earlier, this box was started with .15 i think.)

> 
> Bart
> 

