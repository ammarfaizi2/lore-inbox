Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbULIIww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbULIIww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 03:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbULIIwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 03:52:44 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:13214 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261450AbULIIwl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 03:52:41 -0500
Message-ID: <41B81254.4040107@cyberone.com.au>
Date: Thu, 09 Dec 2004 19:52:36 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
CC: Andrew Morton <akpm@osdl.org>, zaphodb@zaphods.net,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
References: <20041202223146.GA31508@zaphods.net> <20041202145610.49e27b49.akpm@osdl.org> <20041202231837.GB15185@mail.muni.cz> <20041202161839.736352c2.akpm@osdl.org> <20041203121129.GC27716@mail.muni.cz> <41B6343A.9060601@cyberone.com.au> <20041207225932.GB12030@mail.muni.cz> <41B63738.2010305@cyberone.com.au> <20041208111832.GA13592@mail.muni.cz> <41B6E415.4000602@cyberone.com.au> <20041208131442.GF13592@mail.muni.cz>
In-Reply-To: <20041208131442.GF13592@mail.muni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lukas Hejtmanek wrote:

>On Wed, Dec 08, 2004 at 10:23:01PM +1100, Nick Piggin wrote:
>
>>>No better. min_free_kb is set by default to 3831 but I can still reproduce 
>>>this:
>>>
>>>swapper: page allocation failure. order:0, mode:0x20
>>>
>>>
>>What value do you have to raise min_free_kb to in order to be unable to
>>reproduce the warnings?
>>
>
>32MB seems to be ok but it will require further testing to be sure.
>
>

Seems pretty excessive - although maybe your increased socket buffers and
txqueuelen are contributing?

