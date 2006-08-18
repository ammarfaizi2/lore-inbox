Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbWHROwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbWHROwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 10:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbWHROwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 10:52:51 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:63715 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030455AbWHROwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 10:52:50 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: rohitseth@google.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Rik van Riel <riel@redhat.com>, Andi Kleen <ak@suse.de>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44E58059.6020605@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
	 <1155758369.9274.26.camel@localhost.localdomain>
	 <1155774274.15195.3.camel@localhost.localdomain>
	 <1155824788.9274.32.camel@localhost.localdomain>
	 <1155835003.14617.45.camel@galaxy.corp.google.com>
	 <1155835401.9274.64.camel@localhost.localdomain>
	 <1155836198.14617.61.camel@galaxy.corp.google.com> <44E58059.6020605@sw.ru>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 07:52:42 -0700
Message-Id: <1155912762.9274.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 12:54 +0400, Kirill Korotaev wrote:
> > as in page->mapping->container for user land?
> in case of anon_vma, page->mapping can be the same
> for 2 pages beloning to different containers. 

page->mapping->container is the logical way to think about it, but it is
quite easy to get from a mapping, using the VMA list, to the mms mapping
a page.  It wouldn't be a horrible stretch to get back to the tasks (or
directly to the container) from that mm.

Has anyone ever thought of keeping a list of tasks using an mm as a list
hanging off an mm?

-- Dave

