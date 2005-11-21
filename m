Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbVKULhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVKULhI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 06:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVKULhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 06:37:08 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:43389 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932264AbVKULhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 06:37:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:Subject;
  b=xyCfAPqwQ5/nZSWjEy70bSMDI05XztmBXyUcK6kdLfBSBZYrqrLT2/dvhVIh5fZhLAimwBHSRGaydl2YtTMUUEHRhDSNBErdDTgiUrxeI2PLxhJsm9tJ0U7c2whZGeo8wjLKZ8fiBulbG+GkvNFAFY4rTp6B2Wi2b4vWajqr4xw=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
Subject: [patch 0/12] mm: optimisations
Date: Mon, 21 Nov 2005 06:37:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset against 2.6.15-rc2 contains optimisations to the
mm subsystem, mainly the page allocator. Single threaded write-fault
based allocation performance is improved ~5% on G5 with SMP kernel, and
~7% on P4 Xeon with SMP kernel (this measurement includes the full fault
path, page copy, unmapping, and page freeing, so actual kernel allocator
improvement should be larger).

Thanks to feedback from Christoph, Andi, and Bob Picco.

This patchset is cut down to include just straight optimisations and no
behavioural changes.

Nick

-- 
SUSE Labs, Novell Inc.


Send instant messages to your online friends http://au.messenger.yahoo.com 
