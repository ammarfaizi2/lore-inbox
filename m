Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTIXDCk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 23:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbTIXDCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 23:02:40 -0400
Received: from palrel12.hp.com ([156.153.255.237]:39850 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261299AbTIXDCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 23:02:37 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16240.35153.564994.931355@napali.hpl.hp.com>
Date: Tue, 23 Sep 2003 10:56:33 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au,
       bcrl@kvack.org, ak@suse.de, iod00d@hp.com, peterc@gelato.unsw.edu.au,
       linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
In-Reply-To: <20030923102735.42a59d57.davem@redhat.com>
References: <16234.33565.64383.838490@wombat.disy.cse.unsw.edu.au>
	<20030919043847.GA2996@cup.hp.com>
	<20030919044315.GC7666@wotan.suse.de>
	<16234.36238.848366.753588@wombat.chubb.wattle.id.au>
	<20030919055304.GE16928@wotan.suse.de>
	<20030919064922.B3783@kvack.org>
	<16239.38154.969505.748461@wombat.chubb.wattle.id.au>
	<20030922203629.B21836@kvack.org>
	<20030922232237.28a5ac4a.davem@redhat.com>
	<16240.8965.91289.460763@wombat.chubb.wattle.id.au>
	<20030923035118.578203d5.davem@redhat.com>
	<16240.24511.375148.520203@napali.hpl.hp.com>
	<20030923102735.42a59d57.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 23 Sep 2003 10:27:35 -0700, "David S. Miller" <davem@redhat.com> said:

  DaveM> On Tue, 23 Sep 2003 07:59:11 -0700
  DaveM> David Mosberger <davidm@napali.hpl.hp.com> wrote:

  >> The printk() is rate-controlled and doesn't happen for every unaligned
  >> access.  It's average cost can be made as low as we want to, by adjusting
  >> the rate.

  DaveM> But if the event is normal, you shouldn't be logging it as if
  DaveM> it weren't.

An event that causes a slow-down of 500 times or so is not "normal".
On Alpha, we did have just a counter.  Guess what, nobody ever noticed
when things ran much slower than they should have.

  DaveM> Anyone who tries to use IP over appletalk or certain protocols
  DaveM> over PPP are going to see your silly messages.

  DaveM> As I understand it, you even do this stupid printk for user apps
  DaveM> as well, that makes it more than rediculious.  I'd be surprised
  DaveM> if anyone can find any useful kernel messages on an ia64 system
  DaveM> in the dmesg output with all the unaligned access crap there.

Ever heard of prctl --unalign=silent?
I don't normaly do that and I still get very few unaligned warning messages.

	--david
