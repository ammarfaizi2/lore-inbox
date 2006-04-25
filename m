Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWDYKXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWDYKXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 06:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWDYKXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 06:23:39 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:63755 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S932170AbWDYKXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 06:23:39 -0400
Message-ID: <444DF8A7.8060505@superbug.co.uk>
Date: Tue, 25 Apr 2006 11:23:35 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Avi Kivity <avi@argo.co.il>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <1145911546.1635.54.camel@localhost.localdomain> <444D3D32.1010104@argo.co.il> <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com> <444DCAD2.4050906@argo.co.il>
In-Reply-To: <444DCAD2.4050906@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
>>
>>
>> The "advantages" of the former over the latter:
>>
>> (1)  Without exceptions (which are fragile in a kernel), the former 
>> can't return an error instead of initializing the Foo.
> Don't discount exceptions so fast. They're exactly what makes the code 
> clearer and more robust.
>
> A very large proportion of error handling consists of:
> - detect the error
> - undo local changes (freeing memory and unlocking spinlocks)
> - propagate the error
>
> Exceptions make that fully automatic. The kernel uses a mix of gotos 
> and alternate returns which bloat the code and are incredibly error 
> prone. See the recent 2.6.16.x for examples.
C++ exceptions are much more error prone than C. Well not exactly error 
prone, but more non-deterministic.
This is one of the reasons that Software standards allow C++ at lower 
levels, e.g. DAL E, but at higher levels, e.g. DAL B, C++ is not 
allowed, but C is.
So, one can conclude that a C program can be made more reliable than a 
C++ program. One aim of a kernel is reliability.

James
