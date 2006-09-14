Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWINWB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWINWB0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 18:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWINWBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 18:01:25 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:23243 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751306AbWINWBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 18:01:24 -0400
Subject: Re: [Bug] 2.6.18-rc6-mm2 i386 trouble finding RSDT in
	get_memcfg_from_srat
From: Dave Hansen <haveblue@us.ibm.com>
To: kmannth@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, Vivek goyal <vgoyal@in.ibm.com>,
       ebiederm@xmission.com, andrew <akpm@osdl.org>
In-Reply-To: <1158269696.15745.5.camel@keithlap>
References: <1158113895.9562.13.camel@keithlap>
	 <1158269696.15745.5.camel@keithlap>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 15:01:14 -0700
Message-Id: <1158271274.24414.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith, can you get printouts of the phys_addrs it is trying to use
there?  In fact, can you print out all of the calls to all of the
functions and all of their arguments in that file?

I'd also be especially interested in what the actual pte values are that
are getting set, what their addresses are, and what the vaddr of
boot_ioremap_space[] is.

Also, it might be possible that this data somehow got pushed above the
8MB boundary.  Getting me those addresses will let me check that.

-- Dave

