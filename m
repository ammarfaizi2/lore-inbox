Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbUCPFER (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 00:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbUCPFER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 00:04:17 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:20418 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262728AbUCPFEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 00:04:13 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 16 Mar 2004 16:03:57 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16470.35517.840261.107456@notabene.cse.unsw.edu.au>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1 - 4g patch breaks when X86_4G not selected
In-Reply-To: message from Andrew Morton on Monday March 15
References: <20040310233140.3ce99610.akpm@osdl.org>
	<16465.3163.999977.302378@notabene.cse.unsw.edu.au>
	<20040311172244.3ae0587f.akpm@osdl.org>
	<16465.20264.563965.518274@notabene.cse.unsw.edu.au>
	<20040311235009.212d69f2.akpm@osdl.org>
	<16466.57738.590102.717396@notabene.cse.unsw.edu.au>
	<16469.2797.130561.885788@notabene.cse.unsw.edu.au>
	<20040315091843.GA21587@elte.hu>
	<16470.22982.831048.924954@notabene.cse.unsw.edu.au>
	<20040315205201.7699e1c1.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 15, akpm@osdl.org wrote:
> 
> That is useful, thanks.  Sorry about the hassle.
> 
> Calling page_address_init() earlier isn't the fix though - pmd pages aren't
> in highmem so we should never have got that far.  Looks like the pgd or the
> pmd page contains garbage.  Did you try it without
> CONFIG_DEBUG_SLAB?

Without CONFIG_DEBUG_SLAB, it boots OK.

> 
> Nick was seeing slab 0x6b patterns on the NUMAQ, inside the pmd, so there's
> some consistency there.  We do have one early setup fix from Manfred, but
> it's unlikely to cure this.
> 
> I'll have a play with your .config, see if I can reproduce it.  If not I'll
> squeeze off -mm3 and would ask you to retest on that if poss.

When it comes, I'll test it.

thanks,
NeilBrown
