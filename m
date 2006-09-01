Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWIAQF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWIAQF2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWIAQF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:05:28 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:17805 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP id S932289AbWIAQFZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:05:25 -0400
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
In-Reply-To: <1157126162.28577.104.camel@localhost.localdomain>
References: <20060901110908.GB15684@skybase>
	 <1157124821.28577.88.camel@localhost.localdomain>
	 <1157125420.21733.28.camel@localhost>
	 <1157126162.28577.104.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 01 Sep 2006 18:05:15 +0200
Message-Id: <1157126716.21733.45.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 08:56 -0700, Dave Hansen wrote:
> > This question did come up already. arch_free_page() is done before the
> > PageReserved() check so it isn't suitable for stable/unused state
> > transitions. You can argue that arch_free_page() should be moved but who
> > knows what the architecture defined function is supposed to do?
> > page_set_stable/page_set_unused on the other hand have a clearly defined
> > meaning. 
> 
> With a patch set this large, I think it would at least be a nice thing
> to go through and review the other architectures' uses.

There is only one user right now: UML.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


