Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbWCZEES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWCZEES (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 23:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWCZEES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 23:04:18 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:7050 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751564AbWCZEER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 23:04:17 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 25 Mar 2006 20:04:03 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Ulrich Drepper <drepper@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: <alpha/poll.h> change
In-Reply-To: <4425AB3C.8010008@redhat.com>
Message-ID: <Pine.LNX.4.64.0603252003020.12437@alien.or.mcafeemobile.com>
References: <4425AB3C.8010008@redhat.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Mar 2006, Ulrich Drepper wrote:

> Alpha's <sys/poll.h> file was so far compatible with most of the other
> archs (except SPARC).  Since the introduction of POLLREMOVE it's
> different.  In Alpha:
>
> #define POLLREMOVE     (1 << 11)
> +#define POLLRDHUP       (1 << 12)
>
> For the other archs:
>
> #define POLLREMOVE     0x1000
> +#define POLLRDHUP       0x2000
>
>
> For Alpha the values should have been 1<<12 and 1<<13.  Neither
> POLLREMOVE nor POLLRDHUP have been in any glibc header.  How widely are
> they used elsewhere?  Is it too late to change the Alpha definitions to
> match the rest?

As far as I'm concerned this is a brand new thing, so there should be no 
problems in making it right.


- Davide


