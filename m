Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbTIMIgk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 04:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbTIMIgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 04:36:39 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:59058 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S262075AbTIMIgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 04:36:38 -0400
Message-ID: <027d01c379d2$1d7b0380$890010ac@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: "Albert Cahalan" <albert@users.sourceforge.net>,
       "linux-kernel mailing list" <linux-kernel@vger.kernel.org>
References: <1063436451.314.9010.camel@cube>
Subject: Re: "busy" load counters
Date: Sat, 13 Sep 2003 10:36:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Albert Cahalan" <albert@users.sourceforge.net>
> The feature is available, but you'll need to upgrade
> to procps-3.1.12 and linux-2.6.0-test4 at least.
>
> http://www.kernel.org/pub/linux/kernel/v2.6/
> http://procps.sf.net/
>

With procps-3.1.12 and linux-2.6.0-test5, top and ps reports 0.00 time for
multi-threaded programs.

It seems only the 'main' thread is now visible in /proc, and its cpu time
dont include the cpu time of other threads...

Example :

root      1238  0.0  0.0  2692 1576 pts/1    S    08:13   0:00 /bin/bash
root      1293  0.0  0.0  2692 1576 pts/1    S    08:14   0:00 /bin/bash
root      1298  0.0 19.5 716016 658460 pts/1 S    08:14   0:00 ./server
! THIS process certainly has wrong TIME
root      2465  0.0  0.0  2672 1564 pts/2    S    10:19   0:00 -bash


