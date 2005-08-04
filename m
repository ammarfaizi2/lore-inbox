Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVHDSgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVHDSgC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 14:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVHDSgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 14:36:02 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:57108 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S262543AbVHDSf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 14:35:59 -0400
To: yhlu <yhlu.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: mthca and LinuxBIOS
X-Message-Flag: Warning: May contain useful information
References: <20057281331.dR47KhjBsU48JfGE@cisco.com>
	<20057281331.7vqhiAJ1Yc0um2je@cisco.com>
	<86802c44050803175873fb0569@mail.gmail.com>
	<52u0i6b9an.fsf_-_@cisco.com>
	<86802c44050804093374aca360@mail.gmail.com> <52mznxacbp.fsf@cisco.com>
	<86802c4405080410236ba59619@mail.gmail.com>
	<86802c4405080411013b60382c@mail.gmail.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 04 Aug 2005 11:35:44 -0700
In-Reply-To: <86802c4405080411013b60382c@mail.gmail.com> (yhlu's message of
 "Thu, 4 Aug 2005 11:01:55 -0700")
Message-ID: <521x59a6tb.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Aug 2005 18:35:45.0698 (UTC) FILETIME=[53B19820:01C59923]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    yhlu> i enable CCONFIG_INFINIBAND_MTHCA_DEBUG=y I didn't get any
    yhlu> more debug info, is that depend other setting?

It shouldn't depend on anything.  mthca_dbg() gets turned into
dev_dbg(), which just does dev_printk(KERN_DEBUG,...).  Perhaps you
have to change your console level to see KERN_DEBUG messages?

Since you're getting to the call to mthca_init_qp_table(), there are
mthca_dbg() calls that you should definitely be getting output from.

 - R.
