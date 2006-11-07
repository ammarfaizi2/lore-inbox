Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753832AbWKGXeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbWKGXeh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 18:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753867AbWKGXeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 18:34:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18125 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753832AbWKGXeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 18:34:37 -0500
Date: Tue, 7 Nov 2006 23:34:20 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: device-mapper development <dm-devel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Eric Sandeen <sandeen@sandeen.net>,
       Srinivasa DS <srinivasa@in.ibm.com>
Subject: Re: [dm-devel] [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061107233420.GC30653@agk.surrey.redhat.com>
Mail-Followup-To: device-mapper development <dm-devel@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, Eric Sandeen <sandeen@sandeen.net>,
	Srinivasa DS <srinivasa@in.ibm.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <170fa0d20611071218t3c145ef9i5413e432597d78a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170fa0d20611071218t3c145ef9i5413e432597d78a5@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 03:18:08PM -0500, Mike Snitzer wrote:
> Srinivasa's description of the patch just speaks to how freeze_bdev
> and thaw_bdev are used by DM but completely skips justification for
> switching from mutex to semaphore.  Why is it beneficial and/or
> necessary to use a semaphore instead of a mutex here?

This used to be a semaphore; someone changed it to a mutex; we started
getting device-mapper bug reports from people because the usage breaks the
stated semantics for a mutex; this patch puts things back while we consider
if there's a better way of doing things.
 
Alasdair
-- 
agk@redhat.com
