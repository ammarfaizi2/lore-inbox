Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVL3WkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVL3WkS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVL3WkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:40:18 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.25]:31513 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751168AbVL3WkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:40:16 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051230223952.765.21096.sendpatchset@twins.localnet>
Subject: [PATCH] vm: page-replace and clockpro
Date: Fri, 30 Dec 2005 23:40:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

These two patch sets implement a new page replacement algorithm based on
CLOCK-Pro.

The first patch set: page-replace-*, abstracts the current page replace code
and moves it to its own file: mm/page_replace.c.

The second patch set: clockpro-*, then implements a new replace algorithm by
reimplementing the hooks introduced in the previous set.


Andrew, Nick, the kswapd-incmin patch is there again ;-)
I know there is still some disagreement on this patch, however without
it reclaim truely sucks rock with this code.
What happens is that zone_dma is severly overscanned and the clockpro
implementation cannot handle this nicely.


PeterZ
