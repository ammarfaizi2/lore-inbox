Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWHQADq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWHQADq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 20:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWHQADq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 20:03:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44495 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932143AbWHQADp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 20:03:45 -0400
Subject: Re: [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: rohitseth@google.com
Cc: Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <1155755729.22595.101.camel@galaxy.corp.google.com>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 01:22:21 +0100
Message-Id: <1155774141.15195.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-16 am 12:15 -0700, ysgrifennodd Rohit Seth:
> resources will be allocated/freed in context of a user process.  And at
> that time we know if a allocation should succeed or not.  So we may
> actually not need to track kernel pages that closely.

Quite the reverse, tracking kernel pages is critical, user pages kind of
balance out for many cases kernel ones don't.

