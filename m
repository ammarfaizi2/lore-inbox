Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265290AbUGMOzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbUGMOzo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 10:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbUGMOzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 10:55:44 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:41687 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265290AbUGMOzm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 10:55:42 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Dhruv Matani <dhruvbird@gmx.net>, Evaldo Gardenali <evaldo@gardenali.biz>,
       justin.piszcz@mitretek.org
Subject: Re: DriveReady SeekComplete Error...
Date: Tue, 13 Jul 2004 17:01:41 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <1089721822.4215.3.camel@localhost.localdomain> <40F3D4AC.9050407@gardenali.biz> <1089729992.3594.7.camel@localhost.localdomain>
In-Reply-To: <1089729992.3594.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407131701.41218.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Tuesday 13 of July 2004 16:47, Dhruv Matani wrote:
> One more thing I forgot to mention is that if I use that hard 80-pin
> cable, then I do not get such errors at boot time, but get them when
> some service is loading, and if I use the cheaper more flexible
> cable(with possibly lesser number of cables), then I get these errors

You get "BadCRC" errors.  They usually indicate bad cabling.

> while the kernel is loading as well as when some service is loading.
> That service is smartd.

Are you sure it is _exactly_ the same error?

If it is "task_no_data_intr" one then it is harmless
(means that command is not supported by a drive).

You may also want to check http://smartmontools.sf.net

> Again, only in 2.4.20-8, in the previous version(the default that came
> with RedHat-7.2), there is no such problem. Also, I use a re-compiled
> version of the 2.4.20-8 kernel, whereas the default RedHat provided one
> for 7.2, but the errors persist even for the default RedHat-9 kernel
> 2.4.20-8, so I suspect that it's a kernel thing.

RedHat has its own bugtracking system for their kernels.

Please check if you can reproduce the problem with the current
vanilla kernel from kernel.org.

> One more thing! In RedHat-9 with 2.4.20-8, sometimes, the number of
> processes just increases like mad! and the whole system becomes
> unstable. Then I get errors like I/O error, and hda can not be read
> from, and a whole list of blocks.

AFAICS the current kernel for RH9 is kernel-2.4.20-31.9 and you should
be using it instead of > 1 year old 2.4.20-8 version.

Bartlomiej

