Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbUFBKwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUFBKwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 06:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUFBKwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 06:52:16 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:39617 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261830AbUFBKwA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 06:52:00 -0400
Date: Wed, 2 Jun 2004 12:52:03 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Patches for s390.
Message-ID: <20040602105203.GA7108@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
4 patches for s390. The first one contains the definition of
ptep_set_access_flags for s390. We need to flush the tlbs to
reflect changes in the _PAGE_RO bit. The generic function
flushes all tlbs, for s390 we can do better. We want to use
ipte to flush only the tlbs of a single page. Using good old
ptep_establish for ptep_set_access_flags is working just fine.

Short descriptions:
1) s390 core changes.
2) common i/o layer changes.
3) block device driver changes.
4) network driver fixes.

Patches apply against BitKeeper dated 02.06.2004.

blue skies,
  Martin.

