Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTDWPhs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264089AbTDWPhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:37:48 -0400
Received: from imap.gmx.net ([213.165.65.60]:13672 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264088AbTDWPhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:37:47 -0400
Message-ID: <3EA6B61B.7030303@gmx.net>
Date: Wed, 23 Apr 2003 17:49:47 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: BK->CVS, kernel.bkbits.net
References: <20030417162723.GA29380@work.bitmover.com>	<b7n46e$dtb$1@cesium.transmeta.com>	<20030420003021.GA10547@work.bitmover.com> <16035.30645.648954.185797@notabene.cse.unsw.edu.au>
In-Reply-To: <16035.30645.648954.185797@notabene.cse.unsw.edu.au>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> % time bk pull
> ....
> 444.95user 42.29system 49:09.46elapsed 16%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (326737major+196385minor)pagefaults 0swaps
> 
> 
> % time cvs update
> .....
> 2.78user 1.94system 4:12.36elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (333major+7240minor)pagefaults 0swaps
> 
> 
> That is an order of magnitude difference in wall-clock time!  This is
> on my humble notebook with "only" 128Meg of RAM.  The delay is mostly 
> in the consistency checking.  Sure there is a way to turn that off.

Just add this line to your /etc/BitKeeper/etc/config:
[]partial_check:yes!

and you should notice a big speedup.

HTH,
Carl-Daniel

P.S. If anyone knows other speedup tricks for a kernel tree in bk,
please tell me.
-- 
http://www.hailfinger.org/

