Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbUCOWod (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbUCOWoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:44:17 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:27869 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262833AbUCOWl3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:41:29 -0500
Message-ID: <40563114.5040204@cyberone.com.au>
Date: Tue, 16 Mar 2004 09:41:24 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, j-nomura@ce.jp.nec.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [2.4] heavy-load under swap space shortage
References: <Pine.LNX.4.44.0403150822040.12895-100000@chimarrao.boston.redhat.com> <4055BF90.5030806@cyberone.com.au> <20040315145020.GC30940@dualathlon.random> <405628AC.4030609@cyberone.com.au> <20040315222419.GM30940@dualathlon.random>
In-Reply-To: <20040315222419.GM30940@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea Arcangeli wrote:

>
>Either that or you can choose to do some overwork and to shrink from all
>the zones removing this break:
>
>		if (ret >= nr_pages)
>			break;
>
>but as far as I can tell, the 50% waste of cache in a 2G box can happen
>in 2.6.4 and it won't happen in 2.4.x.
>
>

Yeah you are right. Some patches have since gone into 2.6-bk and
this is one of the things fixed up.

Nick

