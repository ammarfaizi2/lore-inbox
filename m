Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbVJUQKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbVJUQKu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 12:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVJUQKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 12:10:50 -0400
Received: from tardis.csc.ncsu.edu ([152.14.51.184]:20160 "EHLO
	tardis.csc.ncsu.edu") by vger.kernel.org with ESMTP id S965013AbVJUQKt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 12:10:49 -0400
Message-ID: <43591307.5050507@csc.ncsu.edu>
Date: Fri, 21 Oct 2005 12:10:47 -0400
From: "Vincent W. Freeh" <vin@csc.ncsu.edu>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Understanding Linux addr space, malloc, and heap
References: <4358F0E3.6050405@csc.ncsu.edu> <1129903396.2786.19.camel@laptopd505.fenrus.org> <4359051C.2070401@csc.ncsu.edu> <1129908179.2786.23.camel@laptopd505.fenrus.org> <43590B23.2090101@csc.ncsu.edu> <C6F7B216-66B3-4848-9423-05AB4D826320@mac.com>
In-Reply-To: <C6F7B216-66B3-4848-9423-05AB4D826320@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, thanks for all the help and attention.  I am learning much.

I think the focus of this discussion should be on mprotect.  I 
understand that spec says it only works on mmap'd memory.  So does 
malloc use mmap?  If not why does it work at all?

Probably the most problematic issue, tho, is why does mprotect return 0 
even though it failed to change permissions on the 66th page?

Kyle Moffett wrote:
> On Oct 21, 2005, at 11:37:07, Vincent W. Freeh wrote:
> You *cannot* reliably expect to mprotect() the results of malloc().   If 
> you want to mprotect() things, you _must_ do it on mmap()ed memory.
> 
> Cheers,
> Kyle Moffett
> 
