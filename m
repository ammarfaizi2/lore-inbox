Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWCHCHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWCHCHs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWCHCHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:07:48 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:52143 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751381AbWCHCHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:07:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=VOtCh5GHT7X3uTJkYgdoL4uLEK1gj1rYPOt8bYOGFlRUr/56WNyCJhQGrVR7PW4d/zWax1Xp+M7siKXib2OHP0JZ/KX2mfz4EQoOR/DvGGmSoIuQrKUm1AmBXiCPooai+hxO4w1UpMOnyQ6f/nONw5sKrRq1oSQ9p1ksPbflpy0=  ;
Message-ID: <440E3C69.2040902@yahoo.com.au>
Date: Wed, 08 Mar 2006 13:07:37 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers
References: <31492.1141753245@warthog.cambridge.redhat.com>
In-Reply-To: <31492.1141753245@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:

>The attached patch documents the Linux kernel's memory barriers.
>
>Signed-Off-By: David Howells <dhowells@redhat.com>
>---
>
>

Good :)

>+==============================
>+IMPLIED KERNEL MEMORY BARRIERS
>+==============================
>+
>+Some of the other functions in the linux kernel imply memory barriers. For
>+instance all the following (pseudo-)locking functions imply barriers.
>+
>+ (*) interrupt disablement and/or interrupts
>

Is this really the case? I mean interrupt disablement only synchronises with
the local CPU, so it probably should not _have_ to imply barriers (eg. some
architectures are playing around with "virtual" interrupt disablement).

[...]

>+
>+Either interrupt disablement (LOCK) and enablement (UNLOCK) will barrier
>+memory and I/O accesses individually, or interrupt handling will barrier
>+memory and I/O accesses on entry and on exit. This prevents an interrupt
>+routine interfering with accesses made in a disabled-interrupt section of code
>+and vice versa.
>+
>

But CPUs should always be consistent WRT themselves, so I'm not sure that
it is needed?

Thanks,
Nick

--
Send instant messages to your online friends http://au.messenger.yahoo.com 
