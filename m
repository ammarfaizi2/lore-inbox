Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbTKLXIy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 18:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTKLXIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 18:08:54 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3850 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261667AbTKLXIw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 18:08:52 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Date: 12 Nov 2003 22:58:14 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <boudu6$k3j$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0311102136280.2881-100000@home.osdl.org> <20031111184919.43a93a88.diegocg@teleline.es>
X-Trace: gatekeeper.tmr.com 1068677894 20595 192.168.12.62 (12 Nov 2003 22:58:14 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031111184919.43a93a88.diegocg@teleline.es>,
Diego Calleja =?ISO-8859-15?Q?Garc=EDa?=  <diegocg@teleline.es> wrote:
| El Mon, 10 Nov 2003 21:40:58 -0800 (PST) Linus Torvalds <torvalds@osdl.org>
| escribió:
| 
| > Now it's your turn. Instead of wasting my time complaining, how about you
| > put up or shut up? Show me the code. THEN post it. Until you do, there's 
| > no point to your mails.
| 
| Until then, I'd suggest this patch to avoid more complains about this:

The object is not to avoid complaints, the object is to get the
capability working again. I presume eventually one of the commercial
vendors will fix it, since it's easier than rewriting all the SCSI
applications in the world. oddly there are people writing useful things
using other operating systems, under 2.4 almost all of those work.

I hope to pick up another IDE tape drive so I can look at this problem,
the one I have is on a production system, which at the moment has no
reason to go to 2.6 even if it worked, which it doesn't. It also has
software to read ZIP drives in odd ways, and I'm not about to look for a
SCSI 100MB ZIP drive :-(

| 
| diff -puN drivers/ide/Kconfig~idescsi-broken drivers/ide/Kconfig
| --- tim/drivers/ide/Kconfig~idescsi-broken	2003-11-11 18:35:23.000000000 +0100
| +++ tim-diego/drivers/ide/Kconfig	2003-11-11 18:36:07.000000000 +0100
| @@ -247,7 +247,7 @@ config BLK_DEV_IDEFLOPPY
|  
|  config BLK_DEV_IDESCSI
|  	tristate "SCSI emulation support"
| -	depends on SCSI
| +	depends on SCSI && BROKEN
|  	---help---
|  	  This will provide SCSI host adapter emulation for IDE ATAPI
| devices, 	  and will allow you to use a SCSI device driver instead of
| a native
| 
| _
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
| 


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
