Return-Path: <linux-kernel-owner+w=401wt.eu-S1161295AbXAHNtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161295AbXAHNtM (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161300AbXAHNtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:49:12 -0500
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:53452 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161295AbXAHNtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:49:11 -0500
Subject: [PATCH 0/4] Improve swap page error handling
From: Richard Purdie <richard@openedhand.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 13:48:43 +0000
Message-Id: <1168264124.5605.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the error handling when writes fail to a swap page. 

Currently, the kernel will repeatedly retry the write which is unlikely
to ever succeed. Instead we allow the pages to be unused and then marked
as bad at which prevents reuse. It should hopefully be suitable for
testing in -mm.

These patches are a based on a patch by Nick Piggin and some of my own
patches/bugfixes as discussed on LKML.

Richard

