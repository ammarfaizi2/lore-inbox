Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVFTPap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVFTPap (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 11:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVFTPap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 11:30:45 -0400
Received: from dvhart.com ([64.146.134.43]:15793 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261329AbVFTPah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 11:30:37 -0400
Date: Mon, 20 Jun 2005 08:30:38 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: 2.6.12-mm1 compile failure on PPC64
Message-ID: <191640000.1119281438@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/built-in.o(.init.text+0x440): In function `.sched_cacheflush':
: undefined reference to `.cacheflush'
make: *** [.tmp_vmlinux1] Error 1
06/20/05-01:28:25 Build the kernel. Failed rc = 2
06/20/05-01:28:25 build: kernel build Failed rc = 1
06/20/05-01:28:25 command complete: (2) rc=126
Failed and terminated the run
 Fatal error, aborting autorun

Works with some configs, but not this one:

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/p570

I'm guessing :

scheduler-cache-hot-autodetect.patch
