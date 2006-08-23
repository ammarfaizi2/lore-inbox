Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWHWMzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWHWMzw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 08:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWHWMzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 08:55:52 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:15569 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932455AbWHWMzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 08:55:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gfXYdrWisUrUouaGwWNWCr7C5IYMIxIxb6XP68pXDMI9ZznYtrAYTIJAiAlg3QSA+MG7ESvWrIdN237gLIizuV44xSDYHuQzCHsiPBCRZyl6y7MKXbehC4U4BVqlDR/bVtCMcP92rxuRHbJsPGLJB64u/osvShf7lfk4BJOn8nI=
Message-ID: <b3f268590608230555o3a03d9d6l1d99a32695e8af6a@mail.gmail.com>
Date: Wed, 23 Aug 2006 14:55:47 +0200
From: "Jari Sundell" <sundell.software@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Cc: "David Miller" <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
       nmiell@comcast.net, linux-kernel@vger.kernel.org, drepper@redhat.com,
       akpm@osdl.org, netdev@vger.kernel.org, zach.brown@oracle.com,
       hch@infradead.org
In-Reply-To: <20060823105104.GA11305@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060822231129.GA18296@ms2.inr.ac.ru>
	 <20060822.173200.126578369.davem@davemloft.net>
	 <b3f268590608221743o493080d0t41349bc4336bdd0b@mail.gmail.com>
	 <20060823065659.GC24787@2ka.mipt.ru>
	 <b3f268590608230122k60e3c7c7y939d5559d97107f@mail.gmail.com>
	 <20060823083859.GA8936@2ka.mipt.ru>
	 <b3f268590608230249q653e1dfh1d77c07f6f4e82ce@mail.gmail.com>
	 <20060823102037.GA23664@2ka.mipt.ru>
	 <b3f268590608230334y6814b886tb79da2f59138acd8@mail.gmail.com>
	 <20060823105104.GA11305@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> We still do not know what uintptr_t is, and it looks like it is a pointer,
> which is forbidden. Those numbers are not enough to make network AIO.
> And actually is not compatible with kqueue already, so you will need to
> write your own parser to convert your parameters into above structure.

7.18.1.4 Integertypes capable of holding object pointers

"1 The following type designates a signed integer type with the
property that any valid
pointer to void can be converted to this type, then converted back to
pointer to void,
and the result will compare equal to the original pointer:"

Dunno if this means that x86-64 needs yet another typedef, or if using
long for intptr_t is incorrect. But assuming a different integer type
was used instead of intptr_t, that is known to be able to hold a
pointer, would there still be any problems?

I'm unable to see anything specific about AIO in your kevent patch
that these modifications wouldn't support.

Rakshasa
