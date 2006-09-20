Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751752AbWITQ2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWITQ2B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWITQ2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:28:01 -0400
Received: from smtp-out.google.com ([216.239.45.12]:36002 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751752AbWITQ2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:28:00 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=fbELe13BNi6gF9rHLwQWFWiJD1hsZy8gKVj/qUCWSOPihVxs5nuNgZ04HHHx9fca3
	Ldr4L8Q/EgfP8tglF0OoA==
Subject: Re: [patch00/05]: Containers(V2)- Introduction
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <4510D3F4.1040009@yahoo.com.au>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <4510D3F4.1040009@yahoo.com.au>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 20 Sep 2006 09:27:46 -0700
Message-Id: <1158769666.8574.10.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 15:39 +1000, Nick Piggin wrote:


> Anyway I don't think I have much to say other than: this is almost
> exactly as I had imagined the memory resource tracking should look
> like. Just a small number of hooks and a very simple set of rules for
> tracking allocations. Also, the possibility to track kernel
> allocations as a whole rather than at individual callsites (which
> shouldn't be too difficult to implement).
> 

I've started looking in that direction.  First shot could just be
tracking kernel memory consumption w/o worrying about whether it is slab
or PT etc.  Hopefully next patchset will have that support integrated.

> If anything I would perhaps even argue for further cutting down the
> number of hooks and add them back as they prove to be needed.
> 

I think the current set of changes (and tracking of different
components) is necessary for memory handler to do the right thing.  Plus
it is possible that user land management tools can also make use of this
information.

> I'm not sure about containers & workload management people, but from
> a core mm/ perspective I see no reason why this couldn't get in,
> given review and testing. Great!
> 

That is great to know. Thanks.  Hopefully it is getting enough coverage
to get there.

-rohit


