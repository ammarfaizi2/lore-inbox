Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266592AbUF3I1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266592AbUF3I1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 04:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266589AbUF3I1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 04:27:33 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:34574 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S266592AbUF3I1U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 04:27:20 -0400
Message-ID: <40E279F4.4090708@hist.no>
Date: Wed, 30 Jun 2004 10:29:40 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Block Device Caching
References: <20040630002014.4970b82d@kingfisher.intern.logi-track.com> <40E1FDEC.6020606@techsource.com>
In-Reply-To: <40E1FDEC.6020606@techsource.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

>
>
> Markus Schaber wrote:
>
>> This lead us to the conclusion that block devices do not cache, but the
>> filesystem does. But subsequently, I ran some tests on my developer
>> machine (Pentium 4 Mobile Laptop).
>
>
>
> I had kernel experts repeatedly insist to me that block devices were 
> cached, while all of my tests (using dd to or from, say, /dev/sda1 or 
> whatever) indicated that there was absolutely no caching whatsoever.

Well, any cache is dropped when the device is closed. "dd" closes the device
when it finishes.

Try a program that reads the same two blocks (spaced videly apart)
over and over from the same open file descriptor.  With _no_ caching 
you'll see
the drive seeking all the time.  With caching, you won't.

Helge Hafting
