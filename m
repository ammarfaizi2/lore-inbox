Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbUK1Di4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbUK1Di4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 22:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbUK1Di4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 22:38:56 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:7877 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261393AbUK1Diz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 22:38:55 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: sam@ravnborg.org
Subject: [patch 0/3] kallsyms: Add gate page and all symbols support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Nov 2004 14:38:47 +1100
Message-ID: <28912.1101613127@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three patches with the overall aim of improving kernel backtraces using
kallsyms.

1 Clean up the special casing of in_gate_area().

2 Add in_gate_area_no_task() for use from places where no task is valid.

3 Treat the gate page as part of the kernel.  Honour CONFIG_KALLSYMS_ALL.

