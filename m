Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbUCHVjw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUCHVjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:39:37 -0500
Received: from palrel10.hp.com ([156.153.255.245]:61639 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261336AbUCHVhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:37:36 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16460.59291.774715.188489@napali.hpl.hp.com>
Date: Mon, 8 Mar 2004 13:37:31 -0800
To: Grant Grundler <iod00d@hp.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix PCI interrupt setting for ia64
In-Reply-To: <20040308063044.GB25960@cup.hp.com>
References: <MDEEKOKJPMPMKGHIFAMAKECGDGAA.kaneshige.kenji@jp.fujitsu.com>
	<20040308063044.GB25960@cup.hp.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 7 Mar 2004 22:30:44 -0800, Grant Grundler <iod00d@hp.com> said:

  Grant> Hi Kenji, I think this behavior exists to support "legacy"
  Grant> IRQ probing.

I don't think so.  probe_irq_on() calls the "startup" callback which
should do an unmask_irq() for I/O SAPIC.  Can somebody confirm that a
Merced box (without Bjorn's patch) will boot fine with Kenji
Kaneshige's patch applied?

	--david
