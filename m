Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWFBIZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWFBIZH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWFBIZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:25:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:14999 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751321AbWFBIZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:25:05 -0400
X-IronPort-AV: i="4.05,202,1146466800"; 
   d="scan'208"; a="45888068:sNHT19185082"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "Con Kolivas" <kernel@kolivas.org>
Cc: <linux-kernel@vger.kernel.org>, "'Chris Mason'" <mason@suse.com>,
       "Ingo Molnar" <mingo@elte.hu>
Subject: RE: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 01:24:57 -0700
Message-ID: <000001c6861e$08d426e0$0b4ce984@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaF+6loioBfyCuzQlWdmdCTMTmSEAAIiCHg
In-Reply-To: <447FBC28.8030401@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Thursday, June 01, 2006 9:19 PM
> Con Kolivas wrote:
> > On Friday 02 June 2006 12:28, Con Kolivas wrote:
> > 
> >>Actually looking even further, we only introduced the extra lookup of the
> >>next task when we started unlocking the runqueue in schedule(). Since we
> >>can get by without locking this_rq in schedule with this approach we can
> >>simplify dependent_sleeper even further by doing the dependent sleeper
> >>check after we have discovered what next is in schedule and avoid looking
> >>it up twice. I'll hack something up to do that soon.
> > 
> > 
> > Something like this (sorry I couldn't help but keep hacking on it).
> 
> Looking pretty good. Nice to acknowledge Chris's idea for
> trylocks in your changelog when you submit a final patch.

Yes, as far as the lock is concerned in dependent_sleeper(), it looks
pretty good. I do have other comments that I will follow up in another
thread.

- Ken
