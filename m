Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbWEYNzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbWEYNzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 09:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbWEYNzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 09:55:39 -0400
Received: from [213.46.243.16] ([213.46.243.16]:1372 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S965167AbWEYNzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 09:55:38 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Thu, 25 May 2006 15:55:34 +0200
Message-Id: <20060525135534.20941.91650.sendpatchset@lappy>
Subject: [PATCH 0/3] mm: tracking dirty pages -v5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I hacked up a new version last night.

Its now based on top of David's patches, Hugh's approach of using the
MAP_PRIVATE protections instead of the MAP_SHARED seems far superior indeed.

Q: would it be feasable to do so for al shared mappings so we can remove
the MAP_SHARED protections all together?

They survive my simple testing, but esp. the msync cleanup might need some
more attention.

I post them now instead of after a little more testing because I'll not 
have much time the coming few days to do so, and hoarding them does 
nobody any good.

Peter
