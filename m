Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbUCLJJp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 04:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUCLJJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 04:09:45 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:59556 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261151AbUCLJJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 04:09:43 -0500
Message-ID: <40517E47.3010909@cyberone.com.au>
Date: Fri, 12 Mar 2004 20:09:27 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Mike Fedyk <mfedyk@matchmail.com>, plate@gmx.tm
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
References: <404FACF4.3030601@cyberone.com.au> <200403111825.22674@WOLK>
In-Reply-To: <200403111825.22674@WOLK>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marc-Christian Petersen wrote:

>On Thursday 11 March 2004 01:04, Nick Piggin wrote:
>
>Hi Nick,
>
>
>>Here is my updated patches rolled into one.
>>
>
>hmm, using this in 2.6.4-rc2-mm1 my machine starts to swap very very soon. 
>Machine has squid, bind, apache running, X 4.3.0, Windowmaker, so nothing 
>special.
>
>Swap grows very easily starting to untar'gunzip a kernel tree. About + 
>150-200MB goes to swap. Everything is very smooth though, but I just wondered 
>because w/o your patches swap isn't used at all, even after some days of 
>uptime.
>
>

Hmm... I guess it is still smooth because it is swapping out only
inactive pages. If the standard VM isn't being pushed very hard it
doesn't scan mapped pages at all which is why it isn't swapping.

I have a preference for allowing it to scan some mapped pages though.
I'm not sure if there is any attempt at a drop behind logic. That
might help. Add new unmapped pagecache pages to the inactive list or
something might help... hmm, actually that's what it does now by the
looks.

I guess you don't have a problem though.

