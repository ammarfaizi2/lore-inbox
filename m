Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbWHQQip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbWHQQip (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 12:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbWHQQio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 12:38:44 -0400
Received: from smtp-out.google.com ([216.239.45.12]:33930 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965120AbWHQQin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 12:38:43 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=M5WuCPxQ+E0dAIqKMzvl355DoDdbZaP+vJyzFMmT0M04BmEU/uiM88rxES9klmnK2
	ZW/co4Fveov7UXUpGA51w==
Subject: Re: [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <1155774141.15195.0.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
	 <1155774141.15195.0.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Google Inc
Date: Thu, 17 Aug 2006 09:36:55 -0700
Message-Id: <1155832615.14617.8.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 01:22 +0100, Alan Cox wrote:
> Ar Mer, 2006-08-16 am 12:15 -0700, ysgrifennodd Rohit Seth:
> > resources will be allocated/freed in context of a user process.  And at
> > that time we know if a allocation should succeed or not.  So we may
> > actually not need to track kernel pages that closely.
> 
> Quite the reverse, tracking kernel pages is critical, 

Having the knowledge of how many kernel pages are getting used by each
container is indeed very useful.  But as long as the context in which
they are created and destroyed is identifiable, there is no need to
really physically tag each page with container id.  And for the cases
where we have no context, it will be worth while to see if mapping field
could be used.


> user pages kind of
> balance out for many cases kernel ones don't.
> 

It is useful to put limits on some group of applications.  So it is
really not only about balancing out.

-rohit

