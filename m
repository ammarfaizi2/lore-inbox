Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWBWJbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWBWJbL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 04:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbWBWJbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 04:31:11 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:4834 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751038AbWBWJbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 04:31:09 -0500
Subject: [Patch 0/3] threaded mmap tweaks
From: Arjan van de Ven <arjan@intel.linux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 10:17:17 +0100
Message-Id: <1140686238.2972.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been looking at a micro-benchmark that basically starts a few
threads which then each allocate some memory (via mmap), use it briefly
and then free it again (munmap). During this benchmark the mmap_sem gets
contended and as a result things go less well than expected. The patches
in this series improved the benchmark by 3% on a wallclock time basis.

Greetings,
   Arjan van de Ven
