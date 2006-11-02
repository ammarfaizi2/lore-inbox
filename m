Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWKBOpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWKBOpA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 09:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWKBOpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 09:45:00 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:47123 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751059AbWKBOo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 09:44:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rvf2su51ovoiIxzI+fBTJIZ8yFptVa7EJ0ppYo9MIn8tbJUrDbVcgVanLiH8menD1f3QFKxVQrBRxPSA7XfWs8L1iVYtrxt6Oq0dlhqdTAERLICve9qj1+iMM5SobQXsUgsA30ypJvo9sorSnD3+9GwMPTk+wpmlz0tQVP7oL8w=
Message-ID: <653402b90611020644m57dac018r443fc91bccf6db0c@mail.gmail.com>
Date: Thu, 2 Nov 2006 14:44:56 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: Franck <vagabon.xyz@gmail.com>
Subject: Re: [PATCH update6] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <454A0006.4090505@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061101014057.454c4f43.maxextreme@gmail.com>
	 <4549B19C.70304@innova-card.com>
	 <653402b90611020544l6e5ded94hc4c932fc1442fcb0@mail.gmail.com>
	 <454A0006.4090505@innova-card.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Miguel Ojeda wrote:
> > On 11/2/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> >> Hi
> >>
> >> Miguel Ojeda Sandonis wrote:
> >> > Andrew, here it is the coding style fixes. Thanks you.
> >> >
> >> > I think the driver is getting ready for freeze until
> >> > 2.6.20-rc1 (if anyone sees something wrong), so I will
> >> > try to send just minor fixes like this.
> >>
> >> :)
> >>
> >> Again, any thoughts on cache aliasing ?
> >>
> >
> > If you have seen something wrong, please tell. What are you thinking about?
>
> Sorry for the short/fast question. I'm wondering how does the cache
> behave here. You have 2 virtual addresses that point to the same
> location in physical RAM: kernel frame buffer which has a kernel
> virtual address and the vma you're returning when an application mmap
> the device. This last address is a user virtual address and is
> different from the first one.
>
> Now let's say that some of the kernel frame buffer data are in the
> data cache and never be invalidate during this example. The

Sorry, I don't understand what do you mean with this sentence.

> application updates its mmapped frame buffer. During the refresh time,
> the kernel take a look to its frame buffer to check if something
> change. Since the 'old' data are still in the data cache and are
> valid, the kernel will use them instead of the new one set by the
> application.

Anyway: The data cache contains "old" data (last buffer data). Right.
The application has changed the buffer. Also OK. Why memcmp won't find
the differences?

What do you mean with "data cache", "kernel fb data", ...?
