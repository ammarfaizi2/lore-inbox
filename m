Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbVHXFJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbVHXFJP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 01:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVHXFJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 01:09:15 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:51584 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751459AbVHXFJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 01:09:14 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 23 Aug 2005 22:09:17 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Davy Durham <pubaddr2@davyandbeth.com>
cc: Willy Tarreau <willy@w.ods.org>, bert hubert <bert.hubert@netherlabs.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: select() efficiency / epoll
In-Reply-To: <430B5802.5050200@davyandbeth.com>
Message-ID: <Pine.LNX.4.63.0508232202580.10064@localhost.localdomain>
References: <42E162B6.2000602@davyandbeth.com> <20050722212454.GB18988@outpost.ds9a.nl>
 <430AF11A.5000303@davyandbeth.com> <20050823182405.GA21301@outpost.ds9a.nl>
 <430B01FB.2070903@davyandbeth.com> <20050823191254.GB10110@alpha.home.local>
 <430B077A.10700@davyandbeth.com> <20050823194557.GC10110@alpha.home.local>
 <430B0EAE.9080504@davyandbeth.com> <20050823202018.GA28724@alpha.home.local>
 <Pine.LNX.4.63.0508231618420.7257@localhost.localdomain> <430B5802.5050200@davyandbeth.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2005, Davy Durham wrote:

> Davide Libenzi wrote:
>
>> 
>> I should mention that the 2.4 patch is old WRT mainline epoll in 2.6 (I 
>> stopped maintaining it when 2.6 went "stable"). I'd definitely suggest to 
>> use 2.6 if you are looking at epoll.
>> 
> I am using linux-2.6.11 and glibc-2.3.4  .. and using select() in it's place 
> seems to work fine.  Are there any known issues with say, one thread does 
> epoll_wait()s while other threads may be doing epoll_ctl()s?

There is no known problem in using epoll_ctl() in one thread while another 
does epoll_wait().
I suggest you to ask Valgrind to take a look at you binary. Since I have 
no clue of what your software does, please create the *minimal* code 
snippet that exploit the eventual problem, and post it.


- Davide

