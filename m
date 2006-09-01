Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751755AbWIATl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbWIATl6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 15:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbWIATl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 15:41:58 -0400
Received: from gw.goop.org ([64.81.55.164]:31371 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751297AbWIATl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 15:41:57 -0400
Message-ID: <44F88510.1070603@goop.org>
Date: Fri, 01 Sep 2006 12:08:00 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/8] Implement per-processor data areas for i386.
References: <20060901064718.918494029@goop.org> <200609011016.45600.ak@suse.de> <44F7EEA2.3090600@goop.org> <200609011030.06859.ak@suse.de>
In-Reply-To: <200609011030.06859.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>> There unfortunately were still quite a lot of rejects because -mm* 
>>> is too different from mainline, but I fixed them all.
>>>   
>>>       
>> Thanks.  Were there more conflicts than entry.S?
>>     
>
> Yes ptrace-abi.h doesn't exist 

That's a bit of a surprise.  I've been working against -mm, so I hadn't 
noticed that it wasn't in mainline.  I had assumed the name was old and 
historical given how inaccurate it is.  I wonder what patch it's part of...

> and the ""s in the Subject of your last patch caused 
> quilt to freak out. I think there was one other too.
>
> I hope everything still works. At least one of my test machines 
> is currently completely unhappy on i386 with random hangs (even before 
> your patches), still bisecting it.
>   

Good luck.  The PDA/CPU startup stuff is all very touchy (I took your 
advice and had good success debugging it with simnow), but once you're 
past that it either works or it doesn't.

    J

