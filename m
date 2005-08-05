Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262883AbVHESPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbVHESPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbVHESNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:13:37 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:57277 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S262827AbVHESLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:11:40 -0400
To: yhlu <yhlu.kernel@gmail.com>, mst@mellanox.co.il
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: mthca and LinuxBIOS
X-Message-Flag: Warning: May contain useful information
References: <20057281331.dR47KhjBsU48JfGE@cisco.com>
	<86802c44050803175873fb0569@mail.gmail.com>
	<52u0i6b9an.fsf_-_@cisco.com>
	<86802c44050804093374aca360@mail.gmail.com> <52mznxacbp.fsf@cisco.com>
	<86802c4405080410236ba59619@mail.gmail.com>
	<86802c4405080411013b60382c@mail.gmail.com> <521x59a6tb.fsf@cisco.com>
	<86802c440508041230143354c2@mail.gmail.com> <52slxp6o5b.fsf@cisco.com>
	<86802c440508051103500f6942@mail.gmail.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 05 Aug 2005 11:11:09 -0700
In-Reply-To: <86802c440508051103500f6942@mail.gmail.com> (yhlu's message of
 "Fri, 5 Aug 2005 11:03:36 -0700")
Message-ID: <52u0i45k5e.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Aug 2005 18:11:20.0499 (UTC) FILETIME=[14C7B830:01C599E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > ib_mthca 0000:04:00.0: FW version 000400060002, max commands 64

This is FW 4.6.2 -- 4.7.0 has been released, so it might be worth
trying that.

    > ib_mthca 0000:04:00.0: NOP command IRQ test passed
    > ib_mthca 0000:04:00.0: mthca_init_qp_table: mthca_CONF_SPECIAL_QP failed for 0/1024 (-16)

Hmm, looks like CONF_SPECIAL_QP is timing out.

MST (or any Mellanox people), any idea why this might happening?  The
NOP command is working fine with interrupts, but CONF_SPECIAL_QP is
timing out.  The difference from the working setup is that the HCA's
local memory is mapped above 4 GB.

 - R.
