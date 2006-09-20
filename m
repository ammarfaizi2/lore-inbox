Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWITRvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWITRvT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWITRvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:51:19 -0400
Received: from smtp-out.google.com ([216.239.45.12]:23745 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932169AbWITRvT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:51:19 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=t0sMScOMlZdRGhHbVF5kMl/urr5KwQnr92RWJwpafcmTbv6Kzart5OpiKN1V6TFgN
	iQxxvwtvTNX5etEnT7NFA==
Subject: Re: [patch00/05]: Containers(V2)- Introduction
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Christoph Lameter <clameter@sgi.com>
In-Reply-To: <451173B5.1000805@yahoo.com.au>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <4510D3F4.1040009@yahoo.com.au> <1158751720.8970.67.camel@twins>
	 <4511626B.9000106@yahoo.com.au> <1158767787.3278.103.camel@taijtu>
	 <451173B5.1000805@yahoo.com.au>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 20 Sep 2006 10:50:57 -0700
Message-Id: <1158774657.8574.65.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 03:00 +1000, Nick Piggin wrote:
> (this time to the lists as well)
> 
> Peter Zijlstra wrote:
> 
>  > I'd much rather containterize the whole reclaim code, which should not
>  > be too hard since he already adds a container pointer to struct page.
> 
> 

Right now the memory handler in this container subsystem is written in
such a way that when existing kernel reclaimer kicks in, it will first
operate on those (container with pages over the limit) pages first.  But
in general I like the notion of containerizing the whole reclaim code.

>  > I still have to reread what Rohit does for file backed pages, that gave
>  > my head a spin.

Please let me know if there is any specific part that isn't making much
sense.

-rohit


