Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbVAVQkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVAVQkH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 11:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVAVQkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 11:40:06 -0500
Received: from bigmama.rhoen.de ([62.80.125.185]:34223 "EHLO rhoen.de")
	by vger.kernel.org with ESMTP id S262591AbVAVQj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 11:39:56 -0500
Date: Sat, 22 Jan 2005 17:30:38 +0100
To: Pete Clements <clem@clem.clem-digital.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ppp in 2.6.11-rc2 Badness in local_bh_enable at kernel/softirq.c
Message-ID: <20050122163038.GB24264@localhost.localdomain>
References: <200501221604.j0MG4vnm001308@clem.clem-digital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501221604.j0MG4vnm001308@clem.clem-digital.net>
User-Agent: Mutt/1.5.6+20040907i
From: boris mogwitz <boris@macbeth.rhoen.de>
X-IN-Kompentent-e-V-MailScanner-Information: Please contact the ISP for more information
X-IN-Kompentent-e-V-MailScanner: Found to be clean
X-MailScanner-From: boris@macbeth.rhoen.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 11:04:57AM -0500, Pete Clements wrote:

> FYI:
> Get the following with 2.6.11-rc2 and ppp (pppoe), continuous.
> Non-ppp boxes fine.  Last prior kernel 2.6.11-rc1-bk5 is good
> (have not tried bk6 - bk9).
>
>  Badness in local_bh_enable at kernel/softirq.c:140
>   [local_bh_enable+44/104] local_bh_enable+0x2c/0x68

 I have a simmilar problem here when I try to access may
 madwifi (cvs) device:

 Badness in local_bh_enable at kernel/softirq.c:140
  [<c011ace3>] local_bh_enable+0x83/0x90
  [<e18ac6c4>] ath_hardstart+0x1b4/0x290 [ath_pci]
  [<c029b966>] arp_create+0x1d6/0x250
  [<c02723d3>] qdisc_restart+0x73/0x150
  [<c026657e>] dev_queue_xmit+0x1be/0x260
  [<c029b2b8>] arp_solicit+0x108/0x200
  [<c026b494>] neigh_timer_handler+0x184/0x2e0
  [<c026b310>] neigh_timer_handler+0x0/0x2e0
  [<c011e9f1>] run_timer_softirq+0xe1/0x1d0
  [<c0106f68>] timer_interrupt+0x48/0xf0
  [<c011ac19>] __do_softirq+0x79/0x90
  cut cut

               mfg
                         boris
								

