Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270811AbTHJXoj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 19:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270814AbTHJXoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 19:44:38 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:46996 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S270811AbTHJXoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 19:44:37 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Mon, 11 Aug 2003 09:44:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16182.55520.115972.757973@gargle.gargle.HOWL>
cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: ext3 badness in 2.6.0-test2
In-Reply-To: message from Mike Fedyk on Friday August 8
References: <20030804142245.GA1627@nevyn.them.org>
	<20030804132219.2e0c53b4.akpm@osdl.org>
	<16176.41431.279477.273718@gargle.gargle.HOWL>
	<20030805235735.4c180fa4.akpm@osdl.org>
	<16178.63046.43567.551323@gargle.gargle.HOWL>
	<20030807181631.2962dfca.akpm@osdl.org>
	<16180.17103.360112.493943@gargle.gargle.HOWL>
	<20030809010544.GC1027@matchmail.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday August 8, mfedyk@matchmail.com wrote:
> On Sat, Aug 09, 2003 at 10:39:43AM +1000, Neil Brown wrote:
> > -		sh = get_active_stripe(conf, new_sector, pd_idx, (bi->bi_rw&RWA_MASK));
> > +		sh = get_active_stripe(conf, new_sector, pd_idx, 0/*(bi->bi_rw&RWA_MASK)*/);
> 
> Wouldn't it be better to remove instead of just commenting out that
> part?

Thew ugliness (hopefuly) reminds me to fix it properly.
I think I can come up with a sensible use for the read-ahead flag, but
I would want to think carefully about it first, and test it somewhat.

NeilBrown
