Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWHKGR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWHKGR2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 02:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWHKGR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 02:17:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44495 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751572AbWHKGR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 02:17:27 -0400
Date: Thu, 10 Aug 2006 23:17:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: Mattia Dongili <malattia@linux.it>, Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 - ext3 locking issue?
Message-Id: <20060810231718.c2b3fe58.akpm@osdl.org>
In-Reply-To: <200608101744.k7AHiXHF004896@turing-police.cc.vt.edu>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<200608091906.k79J6Zrc009211@turing-police.cc.vt.edu>
	<20060809130151.f1ff09eb.akpm@osdl.org>
	<200608092043.k79KhKdt012789@turing-police.cc.vt.edu>
	<200608100332.k7A3Wvck009169@turing-police.cc.vt.edu>
	<44DB1AF6.2020101@gmail.com>
	<20060810082749.6b39a07b.akpm@osdl.org>
	<20060810173312.GC21123@inferi.kami.home>
	<200608101744.k7AHiXHF004896@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 13:44:33 -0400
Valdis.Kletnieks@vt.edu wrote:

> On Thu, 10 Aug 2006 19:33:13 +0200, Mattia Dongili said:
> 
> > oooh, same setup and same trace here, but no yum, see some screenshots
> > here:
> > http://oioio.altervista.org/linux/dsc03448.jpg
> > http://oioio.altervista.org/linux/dsc03449.jpg
> 
> Not quite the same trace - the first few lines are the same, but your call to
> __lock_page() comes in via do_generic_mapping_read(), while Jiri and I are
> seeing the call to __lock_page() coming from truncate_inode_pages_range()....
> 

The suspend+resume->hang bug is known and reputedly fixed.

The stuck-in-lock_page-without-having-done-resume bug is not known. 
Someone please try the deadline scheduler, or AS.

