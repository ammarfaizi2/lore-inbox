Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266902AbUBGQC2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 11:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266955AbUBGQC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 11:02:28 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:28777 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S266902AbUBGQC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 11:02:27 -0500
Date: Sat, 7 Feb 2004 11:01:51 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Michael Frank <mhf@linuxmail.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, <axboe@suse.de>,
       <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.25-rc1: Add user friendliness to highmem= option
In-Reply-To: <200402072338.05365.mhf@linuxmail.org>
Message-ID: <Pine.LNX.4.44.0402071100580.28464-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Feb 2004, Michael Frank wrote:

> Thank you very much for your encouraging response ;)
> 
> What is your opinion on shutting down the kernel on
> zone alignment errors (applies to all arches) and
> the force_bug method it uses to do so?

I think the init code should be smart enough to avoid the
zone alignment errors in the first place.

Still, we should have a fallback in page_alloc.c to check
the arch init code, otherwise problems related to zone
alignment become nearly impossible to debug.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

