Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbUCNDbJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 22:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbUCNDbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 22:31:09 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:36812 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263264AbUCNDbG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 22:31:06 -0500
Message-ID: <4053D1EB.1070108@cyberone.com.au>
Date: Sun, 14 Mar 2004 14:30:51 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [RFC] kref, a tiny, sane, reference count object
References: <20040313082003.GA13084@kroah.com> <20040313163451.3c841ac2.akpm@osdl.org>
In-Reply-To: <20040313163451.3c841ac2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Greg KH <greg@kroah.com> wrote:
>
>>For all of those people, this patch is for you.
>>
>
>It does rather neatly capture a common idiom.
>

But as Andi said - look at all the crap involved when:

atomic_inc();
if (atomic_dec_and_test())
    release();
Also neatly captures that idiom.

And you get more flexibility by being able to use atomic_set
directly too.


But if you really like it, I agree it shouldn't allow NULL
pointers and probably get, put and cleanup should be inline.

