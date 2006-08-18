Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030462AbWHRO6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030462AbWHRO6n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 10:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbWHRO6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 10:58:43 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:22401 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030462AbWHRO6m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 10:58:42 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, rohitseth@google.com,
       hugh@veritas.com, Ingo Molnar <mingo@elte.hu>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44E588F0.40502@sw.ru>
References: <44E33893.6020700@sw.ru> <44E33C8A.6030705@sw.ru>
	 <1155752693.22595.76.camel@galaxy.corp.google.com> <44E46ED3.7000201@sw.ru>
	 <1155825493.9274.42.camel@localhost.localdomain> <44E588F0.40502@sw.ru>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 07:58:33 -0700
Message-Id: <1155913113.9274.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 13:31 +0400, Kirill Korotaev wrote:
> they all are troublesome :/
> user can create lots of vmas, w/o page tables.
> lots of fdsets, ipcids.
> These are not reclaimable. 

I guess one of my big questions surrounding these patches is why the
accounting is done with pages.  If there really is a need to limit these
different kernel objects, then why not simply write patches to limit
*these* *objects*?  I trust there is a very good technical reason for
doing this, I just don't understand why, yet.

-- Dave

