Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTFDEWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 00:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTFDEWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 00:22:42 -0400
Received: from palrel11.hp.com ([156.153.255.246]:28049 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262776AbTFDEWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 00:22:41 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16093.30507.661714.676184@napali.hpl.hp.com>
Date: Tue, 3 Jun 2003 21:35:55 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: niv@us.ibm.com, kuznet@ms2.inr.ac.ru, jmorris@intercode.com.au,
       davidm@hpl.hp.com, gandalf@wlug.westbo.se, linux-kernel@vger.kernel.org,
       linux-ia64@linuxia64.org, netdev@oss.sgi.com, akpm@digeo.com
Subject: Re: fix TCP roundtrip time update code
In-Reply-To: <20030603.202320.59680883.davem@redhat.com>
References: <200306040043.EAA24505@dub.inr.ac.ru>
	<3EDD52F5.8090706@us.ibm.com>
	<20030603.202320.59680883.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 03 Jun 2003 20:23:20 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  DaveM>    From: Nivedita Singhvi <niv@us.ibm.com> Date: Tue, 03 Jun
  DaveM> 2003 19:01:25 -0700
  DaveM>    But, FYI, DaveM and Alexey, we tried reproducing the
  DaveM> stalls we (Dave Hansen, Troy Wilson) had seen during
  DaveM> SpecWeb99 runs and couldn't reproduce them on 2.5.69. (Same
  DaveM> config, etc). So its possible our hang/stalls were some other
  DaveM> issue that got silently fixed (or more likely, possibly the
  DaveM> same thing but other changes minimized us running into the
  DaveM> problem).

  DaveM> I think this means nothing, and that you can infer nothing
  DaveM> from such results.

  DaveM> My understanding is that the problem case triggers only when
  DaveM> a timeout based retransmit occurs.  On LAN this tends to be
  DaveM> extremely rare.  Although under enough traffic load it can
  DaveM> occur.

  DaveM> So if your old SpecWEB99 lab tended more to trigger timeout
  DaveM> based retransmits on LAN, and your new test network does not,
  DaveM> then your new test network will tend to not reproduce the bug
  DaveM> regardless of whether the bug is present in the kernel or not
  DaveM> :-)

Is this where I get to plug httperf?  It triggered the bug reliably in
less than 10 secs. ;-)

	--david
