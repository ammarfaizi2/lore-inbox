Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263489AbTIWTVZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTIWTUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:20:14 -0400
Received: from zeus.kernel.org ([204.152.189.113]:51102 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263487AbTIWTTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:19:38 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16240.35724.423746.180371@napali.hpl.hp.com>
Date: Tue, 23 Sep 2003 11:06:04 -0700
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
Cc: "David S. Miller" <davem@redhat.com>, <davidm@hpl.hp.com>,
       <davidm@napali.hpl.hp.com>, <peter@chubb.wattle.id.au>,
       <bcrl@kvack.org>, <ak@suse.de>, <iod00d@hp.com>,
       <peterc@gelato.unsw.edu.au>, <linux-ns83820@kvack.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: NS83820 2.6.0-test5 driver seems unstable on IA64
In-Reply-To: <BFF315B8E1D7F845B8FC1C28778693D70AFEC6@usslc-exch1.na.uis.unisys.com>
References: <BFF315B8E1D7F845B8FC1C28778693D70AFEC6@usslc-exch1.na.uis.unisys.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 23 Sep 2003 12:58:59 -0500, "Van Maren, Kevin" <kevin.vanmaren@unisys.com> said:

  Van> That's my view on the fpswa printk's (handle_fpu_swa): they are
  Van> normal, expected, and there is absolutely nothing that can be
  Van> done about them -- so why print a "warning" about them (even if
  Van> it is only 5 per second)?  If nothing else, toggle the meaning
  Van> for IA64_THREAD_FPEMU_NOPRINT: turn it ON for special apps.

So what's wrong with doign prctl --fpemul=silent in the init process?
The flags are inherited across fork().

	--david
