Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWBNEKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWBNEKG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 23:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbWBNEKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 23:10:06 -0500
Received: from mx1.suse.de ([195.135.220.2]:4294 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030345AbWBNEKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 23:10:02 -0500
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs / Novell Inc.
To: quilt-dev@nongnu.org
Subject: Re: [Quilt-dev] Quilt 0.43 has been released! [SERIOUS BUG]
Date: Tue, 14 Feb 2006 05:10:54 +0100
User-Agent: KMail/1.8.2
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20060202230210.05a6ad4a.khali@linux-fr.org> <43F14DAA.6000703@bigpond.net.au>
In-Reply-To: <43F14DAA.6000703@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602140510.54960.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 04:25, Peter Williams wrote:
> The problem arises when pushing a patch that has errors in it (due to
> changes in the previous patches in the series) and needs the -f flag to
> force the push.  What's happening is that the reverse of the errors is
> being applied to the "pre patch" file in the .pc directory.  Then when
> you pop this patch it returns the file to a state with the reverse of
> the errors applied to it.

Found and fixed. It's a missed rollback_patch on one of the two branches of 
the code that checks if a patch can be reverse applied. This case apparently 
doesn't trigger as easily as it seems, or else we would have found it sooner. 
Still quite bad.

Shall we wait until the translations are up-to-date again, or release 0.44 
immediately?

> I'm having trouble understanding how quilt could be dumb enough to do
> this as surely the "pre patch" file in the .pc directory should be just
> a copy of the file before the patch is applied.

Hey, it's just a bug.

> This bug can completely hose a set of patches if the user doesn't notice
> it very early and do something about it.  The work around is to revert
> to version 0.42 of quilt.

You should have sent your gquilt announcement to the quilt-dev list as well. 
Thank you for summarizing the changes.

Andreas
