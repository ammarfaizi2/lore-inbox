Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266789AbUHIRnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266789AbUHIRnU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266797AbUHIRnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:43:20 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:30423 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266789AbUHIRnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:43:12 -0400
Message-ID: <4117B849.8090705@sgi.com>
Date: Mon, 09 Aug 2004 12:45:45 -0500
From: Josh Aas <josha@sgi.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, steiner@sgi.com
Subject: Re: [PATCH] Reduce bkl usage in do_coredump
References: <41178C49.3080305@sgi.com> <1092072631.6496.14553.camel@nighthawk>
In-Reply-To: <1092072631.6496.14553.camel@nighthawk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Might be nicer to just put the locking inside of format_corename() if it
> is the function itself that really needs the locking.  If another use of
> it popped up, that user would get the locking for free and couldn't
> possibly forget it.  Also, it's nicer to put the lock closer to the code
> that actually needs it.  Untested patch to do that attached.

Probably a good idea.

> BTW, were you actually seeing a BKL contention problem, or was this just
> for cleanliness?

We have actually seen contention in do_coredump.

-- 
Josh Aas
Silicon Graphics, Inc. (SGI)
Linux System Software
651-683-3068
