Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWIAP4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWIAP4R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWIAP4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:56:17 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:35036 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932111AbWIAP4P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:56:15 -0400
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
From: Dave Hansen <haveblue@us.ibm.com>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
In-Reply-To: <1157125420.21733.28.camel@localhost>
References: <20060901110908.GB15684@skybase>
	 <1157124821.28577.88.camel@localhost.localdomain>
	 <1157125420.21733.28.camel@localhost>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 08:56:02 -0700
Message-Id: <1157126162.28577.104.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 17:43 +0200, Martin Schwidefsky wrote:
> This question did come up already. arch_free_page() is done before the
> PageReserved() check so it isn't suitable for stable/unused state
> transitions. You can argue that arch_free_page() should be moved but who
> knows what the architecture defined function is supposed to do?
> page_set_stable/page_set_unused on the other hand have a clearly defined
> meaning. 

With a patch set this large, I think it would at least be a nice thing
to go through and review the other architectures' uses.

-- Dave

