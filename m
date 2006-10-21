Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993131AbWJUQrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993131AbWJUQrR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993132AbWJUQrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:47:17 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:36999 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S2993131AbWJUQrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:47:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Git training wheels for the pimple faced maintainer
X-Message-Flag: Warning: May contain useful information
References: <4537EB67.8030208@drzeus.cx>
	<Pine.LNX.4.64.0610191629250.3962@g5.osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Sat, 21 Oct 2006 09:47:15 -0700
In-Reply-To: <Pine.LNX.4.64.0610191629250.3962@g5.osdl.org> (Linus Torvalds's message of "Thu, 19 Oct 2006 16:44:41 -0700 (PDT)")
Message-ID: <adabqo5lip8.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Oct 2006 16:47:16.0076 (UTC) FILETIME=[90A75AC0:01C6F530]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Other git maintainers may have other hints about how they work. Anybody?

I use StGIT (http://www.procode.org/stgit/) to have sort of a hybrid
git/quilt workflow.  My infiniband.git tree has the following main
branches (I also keep other topic branches around):

  for-2.6.19
  for-2.6.20
  for-linus
  for-mm
  master

I use master to track Linus's tree.  for-2.6.19 and for-2.6.20 are
StGIT branches that have patches queued up for 2.6.19 and 2.6.20
(duh).  The advantages of StGIT are:

  - I can do "stg pull" to do the equivalent of "git rebase" in a
    slightly cleaner way.
  - If I queue a patch and then someone later says "oops, that patch
    needs this fix," I can go back and revise the patch easily.  This
    means I avoid cluttering the main kernel history with "change X"
    followed by "fix for change X" followed by "update change X"
  - StGIT works within git, so when it is time to send the changes to
    Linus, I can just do "git merge blah for-linus for-2.6.19" and
    then ask Linus to pull the for-linus branch.

 - R.
