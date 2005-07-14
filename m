Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263018AbVGNNyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbVGNNyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 09:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbVGNNyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 09:54:10 -0400
Received: from BTNL-TN-DSL-static-006.0.144.59.touchtelindia.net ([59.144.0.6]:25985
	"EHLO mail.prodmail.net") by vger.kernel.org with ESMTP
	id S263018AbVGNNwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 09:52:05 -0400
Message-ID: <42D66D80.1070106@prodmail.net>
Date: Thu, 14 Jul 2005 19:19:52 +0530
From: RVK <rvk@prodmail.net>
Reply-To: rvk@prodmail.net
Organization: GSEC1
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: Arjan van de Ven <arjan@infradead.org>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Thread_Id
References: <4mfcK-UT-25@gated-at.bofh.it> <4mUJ1-5ZG-23@gated-at.bofh.it> <42CB465E.6080104@shaw.ca> <42D5F934.6000603@prodmail.net> <1121327103.3967.14.camel@laptopd505.fenrus.org> <42D63916.7000007@prodmail.net> <1121337052.3967.25.camel@laptopd505.fenrus.org> <42D64A85.7020305@prodmail.net> <1121343943.3967.32.camel@laptopd505.fenrus.org> <20050714123917.GE4884@devserv.devel.redhat.com>
In-Reply-To: <20050714123917.GE4884@devserv.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jakub Jelinek wrote:

>On Thu, Jul 14, 2005 at 02:25:43PM +0200, Arjan van de Ven wrote:
>  
>
>>pure luck. NPTL threading uses it to store a pointer to per thread info
>>structure; other threading (linuxthreads) may have stored a pid there to
>>identify the internal thread. nptl is 2.6 only so you might have
>>switched implementation of threading when you switched kernels.
>>    
>>
>
>Actually, in linuxthreads what pthread_self () returned has the first slot
>in its internal threads array (up to max number of supported threads)
>that was unused at thread creation time in the low order bits and sequence
>number of thread creation in its high order bits.
>So unless you are using yet another threading library (I thought NGPT
>is dead for years...), the claim that you get the same numbers from
>gettid() syscall under NPTL as pthread_self () gives you under LinuxThreads
>is simply not true.  And you certainly shouldn't be using gettid ()
>syscall in NPTL, as it is just an implementation detail that there is
>a 1:1 mapping between NPTL threads and kernel threads.  It can change
>at any time.
>
>  
>
Which ever is the implementation its expected to be backward compatible. 
Especially thread libraries. As lot of applications using that.

rvk

>	Jakub
>
>  
>

