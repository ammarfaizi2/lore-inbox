Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263272AbUCNEVH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 23:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbUCNEVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 23:21:07 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:28887 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263272AbUCNEVD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 23:21:03 -0500
Message-ID: <4053DDA2.1030708@cyberone.com.au>
Date: Sun, 14 Mar 2004 15:20:50 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: greg@kroah.com, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [RFC] kref, a tiny, sane, reference count object
References: <20040313082003.GA13084@kroah.com>	<20040313163451.3c841ac2.akpm@osdl.org>	<4053D1EB.1070108@cyberone.com.au> <20040313201017.775ab48b.akpm@osdl.org>
In-Reply-To: <20040313201017.775ab48b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>
>>
>>Andrew Morton wrote:
>>
>>
>>>Greg KH <greg@kroah.com> wrote:
>>>
>>>
>>>>For all of those people, this patch is for you.
>>>>
>>>>
>>>It does rather neatly capture a common idiom.
>>>
>>>
>>But as Andi said - look at all the crap involved when:
>>
>>atomic_inc();
>>if (atomic_dec_and_test())
>>    release();
>>Also neatly captures that idiom.
>>
>
>Well it does more than that, such as trapping the hard-to-diagnose bug
>of grabbing a refcount against a zero-ref object.
>
>
>>And you get more flexibility by being able to use atomic_set
>>directly too.
>>
>
>Do I care about that?  I care more about being able to say "ah, it uses
>kref.  I understand that refcounting idiom, I know it's well debugged and I
>know that it traps common errors".  That's better than "oh crap, this thing
>implements its own refcounting - I need to review it for the usual
>errors".
>
>

OK good point.

