Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUD2A5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUD2A5c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 20:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbUD2A5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 20:57:32 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:50027 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262328AbUD2Ayk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 20:54:40 -0400
Message-ID: <4090524C.3020509@yahoo.com.au>
Date: Thu, 29 Apr 2004 10:54:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40904A84.2030307@yahoo.com.au> <20040428205059.A4563@animx.eu.org>
In-Reply-To: <20040428205059.A4563@animx.eu.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
>>I don't know. What if you have some huge application that only
>>runs once per day for 10 minutes? Do you want it to be consuming
>>100MB of your memory for the other 23 hours and 50 minutes for
>>no good reason?
> 
> 
> I keep soffice open all the time.  The box in question has 512mb of ram. 
> This is one app, even though I use it infrequently, would prefer that it
> never be swapped out.  Mainly when I want to use it, I *WANT* it now (ie not
> waiting for it to come back from swap)
> 
> This is just my oppinion.  I personally feel that cache should use available
> memory, not already used memory (swapping apps out for more cache).
> 

On the other hand, suppose that with soffice resident the entire
time, you don't have enough memory to cache an entire kernel tree
(or video you are editing, or whatever).

Now your find | xargs grep keeps taking 30s every time you run
it, or your video is un-editable...
