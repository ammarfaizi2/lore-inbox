Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965539AbWIRIIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965539AbWIRIIW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965542AbWIRIIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:08:22 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:10130 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S965539AbWIRIIU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:08:20 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <200609151352_MC3-1-CB54-526A@compuserve.com>
References: <200609151352_MC3-1-CB54-526A@compuserve.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 18 Sep 2006 10:08:17 +0200
Message-Id: <1158566897.5728.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 13:50 -0400, Chuck Ebbert wrote:
> > I wonder which trick you use, since there is only one page table one
> > i386 I can only imagine that you are tracking all page tables of the
> > guest.
> 
> AMD K8 with the SVM feature has host and guest page tables and
> address-space identifiers for the guests so their global TLB flushes
> can be limited to their own address space...

Yeah, I know about the nested page tables on K8. But VMware will not
restrict themselves to K8 only, so they need a clever way to implement
shadow page tables on i386 chips without this feature.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


