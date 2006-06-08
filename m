Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWFHKFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWFHKFQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWFHKFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:05:15 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:53720 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932089AbWFHKFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:05:13 -0400
Date: Thu, 8 Jun 2006 12:04:39 +0200
From: Voluspa <lista1@comhem.se>
To: Fengguang Wu <wfg@mail.ustc.edu.cn>
Cc: akpm@osdl.org, arjan@infradead.org, Valdis.Kletnieks@vt.edu,
       diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] readahead: initial method - expected read size - fix
 fastcall
Message-Id: <20060608120439.3291f153.lista1@comhem.se>
In-Reply-To: <349756654.19100@ustc.edu.cn>
References: <349406446.10828@ustc.edu.cn>
	<20060604020738.31f43cb0.akpm@osdl.org>
	<1149413103.3109.90.camel@laptopd505.fenrus.org>
	<20060605031720.0017ae5e.lista1@comhem.se>
	<349562623.17723@ustc.edu.cn>
	<20060608094356.5c1272cc.lista1@comhem.se>
	<349754431.09938@ustc.edu.cn>
	<20060608102802.6e07b148.lista1@comhem.se>
	<349756654.19100@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006 16:50:55 +0800 Fengguang Wu wrote:
> On Thu, Jun 08, 2006 at 10:28:02AM +0200, Voluspa wrote:
> > On Thu, 8 Jun 2006 16:13:52 +0800 Fengguang Wu wrote:
> > > It's interesting that copying of sparse file is more efficient with small
> > > readahead size :) I get the same conclusion, though with smaller differences:
> > 
> > How on earth can you copy the file without overwriting the target /dev/null?
> 
> Yes, it worked as expected. All the time.
> 
> I'm running zsh, though bash is also tested ok.
> 
> % cp --version
> cp (GNU coreutils) 5.96
> Copyright (C) 2006 Free Software Foundation, Inc.

root:sleipner:~# dd if=/dev/zero of=sparse bs=1M seek=5000 count=1
1+0 records in
1+0 records out
root:sleipner:~# time cp sparse /dev/null
cp: overwrite `/dev/null'? n

root:sleipner:~# cp --version
cp (coreutils) 5.2.1
Written by Torbjorn Granlund, David MacKenzie, and Jim Meyering.

Copyright (C) 2004 Free Software Foundation, Inc.
[etc...]

Ok, guess it's time to build a more modern system. Was planning to do it
anyway. I don't like just updating something like coreutils...

Mvh
Mats Johannesson
--
