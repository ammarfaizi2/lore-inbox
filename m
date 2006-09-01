Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWIAP5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWIAP5A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWIAP5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:57:00 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:52615 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932125AbWIAP47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:56:59 -0400
Subject: Re: [patch 8/9] Guest page hinting: discarded page list.
From: Dave Hansen <haveblue@us.ibm.com>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gatech.edu
In-Reply-To: <1157125219.21733.24.camel@localhost>
References: <20060901111117.GI15684@skybase>
	 <1157123836.28577.77.camel@localhost.localdomain>
	 <1157125219.21733.24.camel@localhost>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 08:56:43 -0700
Message-Id: <1157126203.28577.106.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 17:40 +0200, Martin Schwidefsky wrote:
> No, unfortunately not. There is a new variable page_discard_list that is
> only defined if CONFG_PAGE_DISCARD_LIST is set. The compiler will
> complain about the absence of the variable, even if the code is never
> reached because PageDiscarded always returns 0.

Ahh.  I see that now.  How about a nice inlined helper function
instead? ;)

-- Dave

