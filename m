Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbUCJUKK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 15:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbUCJUKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 15:10:10 -0500
Received: from palrel12.hp.com ([156.153.255.237]:40843 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262807AbUCJUJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:09:59 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16463.30226.948230.439549@napali.hpl.hp.com>
Date: Wed, 10 Mar 2004 12:09:54 -0800
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix PCI interrupt setting for ia64
In-Reply-To: <MDEEKOKJPMPMKGHIFAMAKECGDGAA.kaneshige.kenji@jp.fujitsu.com>
References: <MDEEKOKJPMPMKGHIFAMAKECGDGAA.kaneshige.kenji@jp.fujitsu.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenji,

Sorry, I lost track of the status of this patch.  Has it been checked
out OK with respect to interrupt probing?

	--david

>>>>> On Mon, 08 Mar 2004 11:49:10 +0900, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> said:

  Kenji> Hi, In ia64 kernel, IOSAPIC's RTEs for PCI interrupts are
  Kenji> unmasked at the boot time before installing device drivers. I
  Kenji> think it is very dangerous.  If some PCI devices without
  Kenji> device driver generate interrupts, interrupts are generated
  Kenji> repeatedly because these interrupt requests are never
  Kenji> cleared. I think RTEs for PCI interrupts should be unmasked
  Kenji> by device driver.
