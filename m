Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266963AbUAXPw0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 10:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266964AbUAXPw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 10:52:26 -0500
Received: from av5-1-sn1.fre.skanova.net ([81.228.11.111]:56043 "EHLO
	av5-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S266963AbUAXPwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 10:52:25 -0500
Subject: Re: [net/8139cp] still crashes my notebook
From: Thomas Svedberg <thsv@am.chalmers.se>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andreas Happe <andreashappe@gmx.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <87vfn24kgn.fsf@devron.myhome.or.jp>
References: <slrnc104io.mp.andreashappe@flatline.ath.cx>
	 <87vfn24kgn.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1074959508.13666.4.camel@Athlon1.hemma.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 24 Jan 2004 16:51:49 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre 2004-01-23 klockan 18.56 skrev OGAWA Hirofumi:
> Andreas Happe <andreashappe@gmx.net> writes:
> 
> > hi,
> > 
> > my notebook (hp/compaq nx7000) still crashes when using 8139cp (runs
> > rock solid with 8139too driver). The computer just locks up, there is no
> > dmesg output. This has happened since I've got this laptop (around
> > november '03).
> 
> It seems 8139cp.c has the race condition of rx_poll and interrupt.
> Does the following patch fix this problem?
> 
> NOTE, since I don't have this device, patch is untested. Sorry.

I can confirm that this patch fixes the same complete lockup I have had
since 2.6.0-test4 or so, (See: "Hard lock with recent 2.6.0-test
kernels").

Tested against 2.6.2-rc1-mm2 which locks har without patch and works
great with it.

-- 
/ Thomas
.......................................................................
 Thomas Svedberg
 Department of Applied Mechanics
 Chalmers University of Technology

 Address: S-412 96 Göteborg, SWEDEN
 E-mail : thsv@bigfoot.com, thsv@am.chalmers.se
 Phone  : +46 31 772 1522
 Fax    : +46 31 772 3827
.......................................................................

