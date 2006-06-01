Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWFAHaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWFAHaS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 03:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWFAHaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 03:30:18 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:57573 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1750761AbWFAHaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 03:30:17 -0400
Message-ID: <00d901c6854d$1fc49230$1800a8c0@dcccs>
From: "Janos Haar" <djani22@netcenter.hu>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: <nathans@sgi.com>, <linux-kernel@vger.kernel.org>, <linux-xfs@oss.sgi.com>
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs> <20060527234350.GA13881@voodoo.jdc.home> <004501c68225$00add170$1800a8c0@dcccs> <9a8748490605280917l73f5751cmf40674fc22726c43@mail.gmail.com> <01d801c6827c$fba04ca0$1800a8c0@dcccs> <01a801c683d2$e7a79c10$1800a8c0@dcccs> <200605301903.k4UJ3xQU008919@turing-police.cc.vt.edu> <1149038431.21827.20.camel@localhost.localdomain> <20060531143849.C478554@wobbly.melbourne.sgi.com> <00f501c68488$4d10c080$1800a8c0@dcccs> <Pine.LNX.4.61.0605312353530.30170@yvahk01.tjqt.qr>
Subject: Re: XFS related hang (was Re: How to send a break? - dump from frozen 64bit linux)
Date: Thu, 1 Jun 2006 09:29:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
To: "Janos Haar" <djani22@netcenter.hu>
Cc: "Nathan Scott" <nathans@sgi.com>; <linux-kernel@vger.kernel.org>;
<linux-xfs@oss.sgi.com>
Sent: Wednesday, May 31, 2006 11:54 PM
Subject: Re: XFS related hang (was Re: How to send a break? - dump from
frozen 64bit linux)


> >
> >Hey, i think i found something.
> >My quota on my huge device is broken.
>
> That should not be a problem. I ran into that "problem" too but had no
> lockups back then (2.6.16-rc1).

 09:21:36 up 23:05,  1 user,  load average: 13.45, 13.14, 13.11
This looks like fixed with disable the quota usage.

The system hangs more often, when i use a script what heavily uses chown and
chgrp and chmod.
Thats why i think, to disable the quota.
At this point it looks like fixed.


>
> >(inferno   -- 18014398504855404       0       0
18446744073709551519
> >0     0)
> >I cant found a way to re-initialize it.
>
> Reinit:
>
> quotaoff /mntpt
> umount /mntpt
> mount /mntpt

Thanks! :-)

Janos


>
> >But anyway, at this point i dont need it, trying to disable the quota
usage.
> >We will see....
>
>
> Jan Engelhardt
> -- 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

