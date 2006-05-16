Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWEPRfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWEPRfr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWEPRfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:35:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:4569 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932178AbWEPRfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:35:45 -0400
Subject: Re: [PATCH] typo in i386/init.c [BugMe #6538]
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, linux-kernel@vger.kernel.org,
       Yasunori Goto <y-goto@jp.fujitsu.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060516102427.2c50d469.akpm@osdl.org>
References: <20060516165040.GA4341@us.ibm.com>
	 <20060516102427.2c50d469.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 16 May 2006 10:34:15 -0700
Message-Id: <1147800855.6623.111.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 10:24 -0700, Andrew Morton wrote:
> And partly because, well, just look at the patch.  It will give the kernel
> new global symbols add_memory() and remove_memory().  So how come it links
> OK at present?

It links OK now with normal configurations, because nobody references
add/remove_memory() unless MEMORY_HOTPLUG is enabled.  The user in the
bug report

	http://bugme.osdl.org/show_bug.cgi?id=6538

managed to enable sparsemem and memory hotplug.  The generic hotplug
code referenced those symbols, and they got a link error.

-- Dave

