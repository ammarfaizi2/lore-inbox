Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUFBSoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUFBSoO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUFBSoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 14:44:13 -0400
Received: from smtp-out4.xs4all.nl ([194.109.24.5]:32274 "EHLO
	smtp-out4.xs4all.nl") by vger.kernel.org with ESMTP id S263806AbUFBSoG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 14:44:06 -0400
Message-ID: <40BE1EBB.7070102@xs4all.nl>
Date: Wed, 02 Jun 2004 20:38:51 +0200
From: John Hendrikx <hjohn@xs4all.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: why swap at all?
References: <200405290037.17775.vda@port.imtp.ilyichevsk.odessa.ua> <E1BTpqM-0005LZ-00@calista.eckenfels.6bone.ka-ip.net> <20040531104928.GA1465@ncsu.edu> <40BC6F0C.7000602@vision.ee> <20040601164946.GA22798@ncsu.edu>
In-Reply-To: <20040601164946.GA22798@ncsu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@unity.ncsu.edu wrote:

>On Tue, Jun 01, 2004 at 02:57:00PM +0300, Lenar L?hmus wrote:
>  
>
>>jlnance@unity.ncsu.edu wrote:
>>
>>    
>>
>>>I'm not sure.  Copying a file is a pretty good indication that you
>>>are about to do something with either the new or the old file.
>>>
>>>      
>>>
>>Like taking the new file with me on USB dongle and deleting old one? 
>>Caching the file really doesn't help in this case.
>>    
>>
>
>No, it does not help in this case.
>
>Not putting things in cache is a solution for the problem of
>having useful stuff pushed out of the cache.  However, fixing
>the problem this way may create other problems if it causes
>us to fail to put useful things into the cache.
>
>The point I was trying (perhaps unsuccessfully) to make, is
>that we should be careful about not caching things.  We are
>likely to break other corner cases by fixing the ones we
>are discussing.
>  
>
I've experienced the problem where applications need to be swapped back 
in.  It's mainly caused by the dual role my machine has (desktop machine 
when I'm using it, server when it is serving files).   Whenever my 
machine has been sitting idly serving files for a while, when I get 
back, the desktop is slow.  However, there is no need for that, as the 
files are served at low speeds -- there's no real point in caching them 
apart from maybe preventing harddisk wear... the harddisk itself can 
serve these files again faster than they will be needed.

So perhaps it is possible to reduce caching of data that is simply not 
putting stress on the system (the harddisk in this case).  If the 
harddisk is not the bottleneck, it is probably not worth caching.  
Typical examples are letting a box play music all day (and then trying 
to read your mail...), having a webserver on a slow connection or 
watching a large movie file.  None of these really require much caching 
beyond a bit of read-ahead. 

I'm not sure how best to distinguish when something is fast I/O that 
would benefit from caching and when something is slow I/O that the 
harddisk can handle well enough on its own.

--John

