Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWINIg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWINIg1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 04:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWINIg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 04:36:27 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:28397 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751459AbWINIg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 04:36:26 -0400
Subject: Re: [patch 0/9] Guest page hinting: cover sheet.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Zachary Amsden <zach@vmware.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
In-Reply-To: <45084524.9090609@vmware.com>
References: <20060901110836.GA15684@skybase>  <45084524.9090609@vmware.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Thu, 14 Sep 2006 10:36:23 +0200
Message-Id: <1158222983.18478.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 10:51 -0700, Zachary Amsden wrote:
> > Only difference of this patch-set compare to the one posted on linux-mm
> > is that this patch-set is against 2.6.18-rc5-mm1. To go back to Andrews
> > question: is this useful for anybody else in addition to s390
> 
> Yes, it is useful for VMware as well.  I am looking through the patches 
> now, and it looks as if they are useful without any changes needed.

That is good news. The current list of changes we are considering is
1) provide batched state transitions for state changes to unused on page
free, from unused to stable on page allocation and to volatile for
page/swap cache pages. Details are still under discussion but I think it
is doable.
2) Get rid of the PG_state_change page flags bit. Use a hashed lock on
the page index instead
3) Get rid of page_host_discards() by defining PageDiscarded() and
friends conditional on CONFIG_PAGE_STATES.

If you can think of anything else that would help wiht the VMware
implementation let me know.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


