Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWH1IZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWH1IZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWH1IZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:25:53 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:1560 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932419AbWH1IZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:25:52 -0400
Message-ID: <44F2A94A.1020004@sw.ru>
Date: Mon, 28 Aug 2006 12:28:58 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Greg KH <greg@kroah.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH] BC: resource beancounters (v2)
References: <44EC31FB.2050002@sw.ru> <44EEE3BB.10303@sw.ru> <20060825073003.e6b5ae16.akpm@osdl.org> <200608251648.00033.ak@suse.de>
In-Reply-To: <200608251648.00033.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>D) Virtual scan of mm's in the over-limit container
>>
>>E) Modify existing physical scanner to be able to skip pages which
>>   belong to not-over-limit containers.
> 
> 
> The same applies to dentries/inodes too, doesn't it? But their
> scan is already virtual so their LRUs could be just split into
> a per container list (but then didn't Christoph L. plan to 
> rewrite that code anyways?)
how do you propose to handle shared files in this case?

> For memory my guess would be that (E) would be easier than (D) for user/file
> memory though less efficient.

Kirill

