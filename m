Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136044AbREBWlp>; Wed, 2 May 2001 18:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136047AbREBWlf>; Wed, 2 May 2001 18:41:35 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:33448 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S136044AbREBWlT>; Wed, 2 May 2001 18:41:19 -0400
Message-ID: <3AF08CC9.3E9946A7@uow.edu.au>
Date: Thu, 03 May 2001 08:40:09 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@cambridge.redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] gcc compile-time assertions
In-Reply-To: <10792.988818374@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> 
> I've written a patch for gcc to implement compile-time assertions with an eye
> to making use of this in the kernel in the future (assuming I can get it to be
> accepted into gcc).
> 

Brilliant. 

It seems that there needs to be a way of detecting the
presence of the feature at compile-time,  so you
can do

#ifndef HAVE_CT_ASSERT
#define __builtin_ct_assert(a, b) do{}while(0)
#endif

or whatever.

Apart from that, I'd suggest you fill out the FSF
damage waiver and see if you can make this part of
stock gcc.

-
