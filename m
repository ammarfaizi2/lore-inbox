Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWHQOct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWHQOct (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWHQOct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:32:49 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:65434 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932509AbWHQOcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:32:47 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 2/7] UBC: core (structures, API)
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44E456F4.10001@sw.ru>
References: <44E33893.6020700@sw.ru> <44E33BB6.3050504@sw.ru>
	 <20060816171527.GB27898@kroah.com>  <44E456F4.10001@sw.ru>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 07:32:40 -0700
Message-Id: <1155825160.9274.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 15:45 +0400, Kirill Korotaev wrote:
> We need more complex decrement/locking scheme than krefs
> provide. e.g. in __put_beancounter() we need
> atomic_dec_and_lock_irqsave() semantics for performance optimizations.

Is it possible to put the locking in the destructor?  It seems like that
should give similar behavior.

-- Dave

