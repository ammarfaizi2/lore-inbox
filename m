Return-Path: <linux-kernel-owner+w=401wt.eu-S1755058AbWL2RQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058AbWL2RQx (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 12:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755060AbWL2RQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 12:16:53 -0500
Received: from mail.screens.ru ([213.234.233.54]:59265 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755057AbWL2RQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 12:16:52 -0500
Date: Fri, 29 Dec 2006 20:17:24 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] re-send of flush_workqueue/flush_work patches
Message-ID: <20061229171724.GA147@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes:

[PATCH 1/2] reimplement flush_workqueue()

	Not changed, just re-diff against 2.6.20-rc2-mm1

[PATCH 2/2] implement flush_work()

	Fix a race vs cpu-hotplug. The work should be dequeued before
	we check any CPU for ->current_work == work, otherwise the work
	can migrate to already checked CPU.

Oleg.

