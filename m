Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVELQSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVELQSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 12:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVELQSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 12:18:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19617 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262072AbVELQS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 12:18:29 -0400
Date: Thu, 12 May 2005 12:18:26 -0400
From: Dave Jones <davej@redhat.com>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] enhance x86 MTRR handling
Message-ID: <20050512161825.GC17618@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <s2832b02.028@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s2832b02.028@emea1-mh.id2.novell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 11:08:21AM +0200, Jan Beulich wrote:

 > - the code to correct inconsistent settings during secondary processor
 >   startup tried (if necessary) to correct, among other things, the value
 >   in IA32_MTRR_DEF_TYPE, however the newly compute value would never get
 >   used to be stored in the respective MSR
 > - the generic range validation code checked that the end of the
 >   to-be-added range would be above 1MB; the value checked should have been
 >   the start of the range
 > - when contained regions are detected, previously this was allowed only
 >   when the old region was uncacheable; this can be symmetric (i.e. the new
 >   region can also be uncacheable) and even further as per Intel's
 >   documentation write-trough and write-back for either region is also
 >   compatible with the respective opposite in the other

Whilst your changes may have merit, I'd much rather see effort spent
on getting PAT into shape than further massaging MTRR.  Its well past its
smell-by-date, and theres been no activity whatsoever afaik on getting
Terrence Ripperda's cachemap stuff beaten into shape.

I'll dust off the last version he sent and diff against latest-mm later
so it can get some more commentary. It seems everyone is in violent
agreement that we want PAT support, but nothing seems to happen.

		Dave

