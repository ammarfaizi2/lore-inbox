Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161134AbWJKRPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbWJKRPm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 13:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161135AbWJKRPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 13:15:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:62141 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1161134AbWJKRPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 13:15:40 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,295,1157353200"; 
   d="scan'208"; a="144805105:sNHT25170306"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Arjan van de Ven'" <arjan@infradead.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Peter Zijlstra" <a.p.zijlstra@chello.nl>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
       "Nick Piggin" <npiggin@suse.de>
Subject: RE: RSS accounting (was: Re: 2.6.19-rc1-mm1)
Date: Wed, 11 Oct 2006 10:15:39 -0700
Message-ID: <000101c6ed58$e01d2830$1680030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcbtPOq4GPd2siFTSb6K1nVixbFnxgAF7JHw
In-Reply-To: <1160574913.3000.378.camel@laptopd505.fenrus.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote on Wednesday, October 11, 2006 6:55 AM
> > Well I tried to defined it in terms of what you can use it for.
> > 
> > I would define the resident set size as the total number of bytes
> > of physical RAM that a process (or set of processes) is using,
> > irrespective of the rest of the system.  
> > 
> > So I think the counting should be primarily about what is mapped into
> > the page tables.  But other things can be added as is appropriate or
> > easy.
> > 
> > The practical effect should be that an application that needs more
> > pages than it's specified RSS to avoid thrashing should thrash but
> > it shouldn't take the rest of the system with it.
> 
> 
> so by your definition, hugepages are part of RSS.
> 
> Ken: what is your definition of RSS ?

I'm more inclined to define RSS as "how much ram does my application
cause to be used".  To monitor process's working set size, We already
have /proc/<pid>/smaps.  Whether we can use working set size in an
intelligent way in mm is an interesting question. Though, so far such
accounting is not utilized at all.

- Ken
