Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUGBJWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUGBJWh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 05:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUGBJWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 05:22:37 -0400
Received: from burro.logi-track.com ([213.239.193.212]:12688 "EHLO
	mail.logi-track.com") by vger.kernel.org with ESMTP id S261184AbUGBJWY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 05:22:24 -0400
Date: Fri, 2 Jul 2004 11:21:59 +0200
From: Markus Schaber <schabios@logi-track.com>
To: Markus Schaber <schabios@logi-track.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: CCISS driver and Caching (was: Block Device Caching)
Message-Id: <20040702112159.5cbf0974@kingfisher.intern.logi-track.com>
In-Reply-To: <20040630083009.18c5e216@kingfisher.intern.logi-track.com>
References: <20040630002014.4970b82d@kingfisher.intern.logi-track.com>
	<20040629224622.GQ15166@schnapps.adilger.int>
	<20040630083009.18c5e216@kingfisher.intern.logi-track.com>
Organization: logi-track ag, =?ISO-8859-15?Q?z=FCrich?=
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: Nx5T&>Nj$VrVPv}sC3IL&)TqHHOKCz/|)R$i"*r@w0{*I6w;UNU_hdl1J4NI_m{IMztq=>cmM}1gCLbAF+9\#CGkG8}Y{x%SuQ>1#t:;Z(|\qdd[i]HStki~#w1$TPF}:0w-7"S\Ev|_a$K<GcL?@F\BY,ut6tC0P<$eV&ypzvlZ~R00!A
X-PGP-Key: http://schabi.de/pubkey.asc
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We did some additional tests, and just learned that the underlying raid
itsself is not cached by the linux kernel:


bear:~/readcachetest# ./readcache /dev/cciss/c0d0p2 1000
frist run needed 16.006950 seconds, this is 62.472863 MBytes/Sec
second run needed 15.919336 seconds, this is 62.816690 MBytes/Sec
third run needed 15.830325 seconds, this is 63.169897 MBytes/Sec

So we now think it's some problem of the cciss driver, and not of lvm.

weird...

Markus


-- 
markus schaber | dipl. informatiker
logi-track ag | rennweg 14-16 | ch 8001 zürich
phone +41-43-888 62 52 | fax +41-43-888 62 53
mailto:schabios@logi-track.com | www.logi-track.com
