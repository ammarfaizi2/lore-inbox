Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161065AbWJKPHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbWJKPHS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 11:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbWJKPHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 11:07:18 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:10827 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S965228AbWJKPHQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 11:07:16 -0400
Subject: Re: [patch 3/3] mm: add arch_alloc_page
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Nick Piggin <npiggin@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061011145643.GA5259@wotan.suse.de>
References: <20061007105758.14024.70048.sendpatchset@linux.site>
	 <20061007105824.14024.85405.sendpatchset@linux.site>
	 <20061007134345.0fa1d250.akpm@osdl.org> <452856E4.60705@yahoo.com.au>
	 <1160578104.634.2.camel@localhost>  <20061011145643.GA5259@wotan.suse.de>
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 11 Oct 2006 17:07:16 +0200
Message-Id: <1160579236.634.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 16:56 +0200, Nick Piggin wrote:
> > With Nicks patch I can use arch_alloc_page instead of page_set_stable,
> > but I can still not use arch_free_page instead of page_set_unused
> > because it is done before the check for reserved pages. If reserved
> > pages go away or the arch_free_page call would get moved after the check
> > I could replace page_set_unused as well. So with Nicks patch we are only
> > halfway there..
> 
> Ahh, but with my patchSET I think we are all the way there ;)

Oh, good. Then I only have to add two more state change functions,
namely page_make_stable and page_make_volatile.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


