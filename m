Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267712AbUHFEiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267712AbUHFEiR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 00:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268063AbUHFEiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 00:38:17 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:25783 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267712AbUHFEiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 00:38:15 -0400
Message-ID: <41130B34.2050201@yahoo.com.au>
Date: Fri, 06 Aug 2004 14:38:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Shantanu Goel <sgoel01@yahoo.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [VM PATCH 2.6.8-rc1] Prevent excessive scanning of lower zone
References: <20040805000205.53959.qmail@web12823.mail.yahoo.com>
In-Reply-To: <20040805000205.53959.qmail@web12823.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shantanu Goel wrote:
> Hi Andrew,
> 
> --- Andrew Morton <akpm@osdl.org> wrote:
> 
> 
>>Shantanu Goel <sgoel01@yahoo.com> wrote:
>>
>>>I emailed this a few weeks back to the list but it
>>>seems to have gotten lost...
>>
>>It came through.  I was unable to reproduce the
>>disproportional scanning
>>rate on almost exactly the same setup, so I parked
>>the problem for a while.
>>
>>I do agree with the analysis though.  The problem
>>_could_ occur.  I dunno
>>why it happens for you and not for me...
>>
> 
> 
> Actually, the analysis turned out to be not entirely
> correct.  I think I have identified the offending
> code.  Please see attached patch.  It makes kswapd()
> skip zones which contain greater than "pages_high"
> pages.
> 

You'd think so, but that isn't quite right. That blows
the incremental min thing in the page allocator.

I'm just about to send out a couple of patches for
comment on linux-mm, one of which should fix your problem.
I'll cc you on it.
