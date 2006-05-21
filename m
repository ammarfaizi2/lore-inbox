Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWEUOlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWEUOlr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 10:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWEUOlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 10:41:47 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:40588 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S964878AbWEUOlq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 10:41:46 -0400
Message-ID: <44707C9D.1070606@cmu.edu>
Date: Sun, 21 May 2006 10:43:41 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060503)
MIME-Version: 1.0
To: nick@linicks.net
CC: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
Subject: Re: cannot load *any* modules with 2.4 kernel
References: <446F3F6A.9060004@cmu.edu> <20060520162529.GT11191@w.ods.org>	 <446FAEE3.6060003@cmu.edu> <7c3341450605210032j9eb3da6y5f307a3198957214@mail.gmail.com>
In-Reply-To: <7c3341450605210032j9eb3da6y5f307a3198957214@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before I build i do:
PATH=/usr/local/modutils/sbin:$PATH

Therefore it must be reading it first, sorry I should have mentioned
this... just have done so much to try and get it to work I can't
remember it all :)

In response to Willy's post, yeah it was by hand, i can't get that comp
on the network yet :(

I will answer all your detailed questions and rebuild the kernel, but it
didn't have any revisions after names, I'll rebuild with that exact
.config i posted after a make clean mrproper to ensure its installing
the new kernel.  Then I'll also try disabling modversion.

Thanks!
George


Nick Warne wrote:
> On 21/05/06, George Nychis <gnychis@cmu.edu> wrote:
>> Okay, so heres what I did.  I downloaded modutils version 2.4.27 and
>> extracted it to /usr/local/modutils
>>
>> Then in my 2.4.32 kernel's Makefile, I changed the DEPMOD variable to
>> point to /usr/local/modutils/sbin/depmod
>>
> 
> Well thats a half-arsed way to do it.  The kernel makefile could be
> using the new /usr/local/sbin/depmod and the system the old
> /sbin/depmod /sbin/insmod /sbin/modprobe etc.
> 
> Just install the new modutils to /usr/local/ and then add
> /usr/local/sbin to your $PATH _before_  /sbin etc. so it is read
> first.
> 
> Nick
> 
