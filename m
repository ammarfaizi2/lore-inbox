Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbTD1Bdz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 21:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbTD1Bdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 21:33:55 -0400
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:4736 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP id S263156AbTD1Bdw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 21:33:52 -0400
Message-ID: <3EAC87CD.82C5F4A6@cinet.co.jp>
Date: Mon, 28 Apr 2003 10:45:49 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.68-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.67-ac2 fix new PIO handlers
References: <Pine.SOL.4.30.0304272011560.27252-200000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> During rewrite of bio walking patch to use rq->cbio instead
> of rq->hard_bio I've realized I had screwed orig 2.5.66 patches :\
> 
> I somehow forgot to update task_map_rq(), it should use
> __bio_kmap_irq(rq->bio, current_idx, flags) instead of
> bio_kmap_irq(rq->bio, flags). The result is that you get
> bio corruption (-> data corruption) when using PIO multiple
> with sectors multiply > 8 (PAGE_SIZE == bio_vec size).
> 
> Attached patch fixes it and fixes TASKFILE ioctl.
> 
> Please apply to next -ac.
Could you please tell me how to apply your patch. Aginst 2.5.62-ac2?
I have a ext2 fs corruption problem at PIO mode on 2.5.67-ac2.
There is no problem on vanilla 2.5.67.
I tryed the all patches below.
 tf-ioctls-1.diff
 tf-ioctls-2a.diff
 tf-ioctls-2b.diff
 tf-ioctls-3.diff
 tf-ioctls-4.diff
 tf-dio-1.diff
 tf-dio-2.diff
 tf-dio-3.diff
 tf-dio-4.diff
 masked-irq.diff
They didn't solve problem.
This pio-fixes.diff can't be applied after them?

Regards,
Osamu Tomita
