Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWFHI2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWFHI2b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 04:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWFHI2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 04:28:31 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:3775 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932560AbWFHI2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 04:28:30 -0400
Date: Thu, 8 Jun 2006 10:28:02 +0200
From: Voluspa <lista1@comhem.se>
To: Fengguang Wu <wfg@mail.ustc.edu.cn>
Cc: akpm@osdl.org, arjan@infradead.org, Valdis.Kletnieks@vt.edu,
       diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] readahead: initial method - expected read size - fix
 fastcall
Message-Id: <20060608102802.6e07b148.lista1@comhem.se>
In-Reply-To: <349754431.09938@ustc.edu.cn>
References: <349406446.10828@ustc.edu.cn>
	<20060604020738.31f43cb0.akpm@osdl.org>
	<1149413103.3109.90.camel@laptopd505.fenrus.org>
	<20060605031720.0017ae5e.lista1@comhem.se>
	<349562623.17723@ustc.edu.cn>
	<20060608094356.5c1272cc.lista1@comhem.se>
	<349754431.09938@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006 16:13:52 +0800 Fengguang Wu wrote:
> It's interesting that copying of sparse file is more efficient with small
> readahead size :) I get the same conclusion, though with smaller differences:

How on earth can you copy the file without overwriting the target /dev/null?
As you saw, I could just "cat" the file. Size was:

root:sleipner:~# dd if=/dev/zero of=sparse bs=1M seek=5000 count=1
1+0 records in
1+0 records out
root:sleipner:~# ls -l sparse 
1040 -rw-r--r--  1 root root 5243928576 Jun  8 10:26 sparse

5.2 fake GBs...

Mvh
Mats Johannesson
--
