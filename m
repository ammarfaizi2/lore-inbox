Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbTDUEfH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 00:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbTDUEfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 00:35:07 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:58812 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263761AbTDUEfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 00:35:05 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Larry McVoy <lm@bitmover.com>
Date: Mon, 21 Apr 2003 14:46:45 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16035.30645.648954.185797@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BK->CVS, kernel.bkbits.net
In-Reply-To: message from Larry McVoy on Saturday April 19
References: <20030417162723.GA29380@work.bitmover.com>
	<b7n46e$dtb$1@cesium.transmeta.com>
	<20030420003021.GA10547@work.bitmover.com>
X-Mailer: VM 7.14 under Emacs 21.2.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday April 19, lm@bitmover.com wrote:
>                              By the way, I think the bandwidth is pretty
> darn low, after all that fuss almost nobody seems to use this, it just
> gives them warm fuzzies to know that the history has been captured in
> an open format which is worth it if it means no more BK flame wars, eh?


Well, I just became a big fan:

% time bk pull
....
444.95user 42.29system 49:09.46elapsed 16%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (326737major+196385minor)pagefaults 0swaps


% time cvs update
.....
2.78user 1.94system 4:12.36elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (333major+7240minor)pagefaults 0swaps


That is an order of magnitude difference in wall-clock time!  This is
on my humble notebook with "only" 128Meg of RAM.  The delay is mostly 
in the consistency checking.  Sure there is a way to turn that off.

NeilBrown

(I only used bk to
   "bk tag LATEST  ; bk pull; bk export -tpatch -rLATEST, > file"
 and cvs will allow the same end result)
