Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVD1Q0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVD1Q0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 12:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVD1Q0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 12:26:50 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:1288 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262156AbVD1Q0q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 12:26:46 -0400
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, skodati@in.ibm.com
Subject: Re: [PATCH] drop_buffers() shouldn't de-ref page->mapping if its NULL
References: <1114645113.26913.662.camel@dyn318077bld.beaverton.ibm.com>
	<1114646015.26913.668.camel@dyn318077bld.beaverton.ibm.com>
	<87k6mn5zs6.fsf@devron.myhome.or.jp>
	<1114701153.26913.679.camel@dyn318077bld.beaverton.ibm.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 29 Apr 2005 01:26:27 +0900
In-Reply-To: <1114701153.26913.679.camel@dyn318077bld.beaverton.ibm.com> (Badari Pulavarty's message of "28 Apr 2005 08:12:34 -0700")
Message-ID: <87oebyeuks.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> writes:

> Andrew confirmed that this is a valid case.
>
> I don't understand what you want to do here ? If the mapping is NULL,
> we can't de-ref it.  Whats the point in putting a warning and de-refing
> it. Its going to cause NULL pointer de-ref anyway.

I meant your patch + warning. If it is just bh leak, not valid state,
I thought we can notice the leak of bh by warning.

I wanted above things. If it's valid state, of course warning is just
crap.

Sorry for noise.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
