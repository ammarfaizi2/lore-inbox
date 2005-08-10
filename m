Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbVHJUJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbVHJUJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbVHJUJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:09:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22165 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030245AbVHJUJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:09:53 -0400
Message-Id: <20050810200216.644997000@jumble.boston.redhat.com>
Date: Wed, 10 Aug 2005 16:02:16 -0400
From: Rik van Riel <riel@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH/RFT 0/5] CLOCK-Pro page replacement
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here it is, the result of many months of thinking and a few
all-nighters.  CLOCK-Pro page replacement is an algorithm
designed to keep those pages on the active list that were
referenced "most frequently, recently", ie. the pages that
have the smallest distance between the last two subsequent
references.

I had to make some changes to the algorithm in order to
reduce the space overhead of keeping track of non-resident
pages, as well as work in a multi-zone VM.

The algorithm still needs lots of testing, and probably tuning:
- should new anonymous pages start out on the active or
  the inactive list ?
- is this implementation of the algorithm buggy ?
- are there performance regressions ?

I have only done very rudimentary testing of the algorithm
here, and while it appears to be behaving as expected, I do
not know whether the expected behaviour is the right thing...

I think I have acted on all the feedback people have given
me on the non-resident pages patch set.

Any comments, observations, etc. are appreciated.

-- 
All Rights Reversed
