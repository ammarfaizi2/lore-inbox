Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbUK0DpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbUK0DpC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUK0Dop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:44:45 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262661AbUKZTfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:35:46 -0500
Subject: Re: [PATCH 2.6.10-rc2-mm3] mips: fixed memory mapped I/O of IDE on
	MIPS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mips@linux-mips.org
In-Reply-To: <20041124175155.GE21039@linux-mips.org>
References: <20041124101809.77a1d877.yuasa@hh.iij4u.or.jp>
	 <20041124175155.GE21039@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101395868.18214.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 25 Nov 2004 15:17:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You also need to implement the OUTBNOSYNC operator correctly if you are
using mmio and your bridge does PCI posting. Without that you'll get the
odd problem if the IDE IRQ line is shared.

