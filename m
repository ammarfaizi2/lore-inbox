Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbTDCSWp 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 13:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261542AbTDCSWp 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 13:22:45 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:32649 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261521AbTDCSWj 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 13:22:39 -0500
Date: Thu, 03 Apr 2003 10:34:52 -0800
From: Nehal <nehal@canada.com>
Subject: Re: mount hfs on SCSI cdrom = segfault
In-reply-to: <XFMail.20030403183058.pochini@shiny.it>
To: linux-kernel@vger.kernel.org
Reply-to: linux-kernel@vger.kernel.org
Message-id: <3E8C7ECC.70300@canada.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
References: <XFMail.20030403183058.pochini@shiny.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:

>>>Once upon a time it worked just fine. Then someone removed
>>>support for !=512 bytes sectors...
>>>To workaround, use loopback.
>>>
>>>      
>>>
>>(yes Oliver has told me about this workaround)
>>
>>1. do u know why it was removed?
>>2. is there a reason why can't support for it be put back?
>>    
>>
>
>I don't know why, and I don't know if it was removed from the
>hfs code or if hfs relied on some features of a lower layer
>that has been modified.
>  
>
i did some searching around and only found that this
problem started during 2.3.x because of a scsi rewrite

anyways, i did try the loop method, it did not work,
i got a segmentation fault when i did the following:

    losetup /dev/loop0 /dev/scd0
    mount -r -t hfs /dev/loop0 /cdrom

oh well, i'll just use my IDE drive for now..

thx anyways, Nehal


