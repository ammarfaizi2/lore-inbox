Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWIAPbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWIAPbW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbWIAPbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:31:22 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:60331 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751544AbWIAPbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:31:21 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1157122667.28577.69.camel@localhost.localdomain>
References: <20060901110948.GD15684@skybase>
	 <1157122667.28577.69.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 01 Sep 2006 17:31:14 +0200
Message-Id: <1157124674.21733.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 07:57 -0700, Dave Hansen wrote:
> > +#define PG_state_change                21      /* HV page state is changing. */
> > +#define PG_discarded           22      /* HV page has been discarded. */ 
> 
> We're already desperately short on page flags on 32-bit architectures.
> It seems a wee bit silly to add two arch-generic flags for what is a
> very specialized arch-specific feature at this point.

There are even three additional page flags if you apply the full set of
patches.

> I know that there are 32-bit s390 kernels, but would this be a
> reasonable feature to restrict to only 64-bit kernels?  That might be a
> decent compromise.

Yes, it is definitly an option to make this a 64-bit only features. In
particular because the ESSA instruction that is used on s390 is only
available in zarch mode (=64 bit).

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


