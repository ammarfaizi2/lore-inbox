Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266854AbUFYTC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266854AbUFYTC0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 15:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266832AbUFYTBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 15:01:37 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:47294 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266839AbUFYS7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 14:59:53 -0400
Subject: Re: [Lhms-devel] Re: Merging Nonlinear and Numa style memory
	hotplug
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <ygoto@us.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       Linux-Node-Hotplug <lhns-devel@lists.sourceforge.net>,
       linux-mm <linux-mm@kvack.org>,
       "BRADLEY CHRISTIANSEN [imap]" <bradc1@us.ibm.com>
In-Reply-To: <20040625114720.2935.YGOTO@us.fujitsu.com>
References: <20040624194557.F02B.YGOTO@us.fujitsu.com>
	 <1088133541.3918.1348.camel@nighthawk>
	 <20040625114720.2935.YGOTO@us.fujitsu.com>
Content-Type: text/plain
Message-Id: <1088189973.29059.231.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 25 Jun 2004 11:59:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-25 at 11:48, Yasunori Goto wrote:
> > 
> > > Should this translation be in common code?
> > 
> > What do you mean by common code?  It should be shared by all
> > architectures.
> 
> If physical memory chunk size is larger than the area which
> should be contiguous like IA32's kmalloc, 
> there is no merit in this code.
> So, I thought only mem_section is enough.
> But I don't know about other architecutures yet and I'm not sure.
> 
> Are you sure that all architectures need phys_section?

You don't *need* it, but the alternative is a scan of the mem_section[]
array, which would be much, much slower.

Do you have an idea for an alternate implementation?

-- Dave

