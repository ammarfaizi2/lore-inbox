Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWDVUUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWDVUUR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWDVUUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:20:17 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:28132 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751124AbWDVUUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:20:15 -0400
Date: Sat, 22 Apr 2006 22:18:36 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Hua Zhong <hzhong@gmail.com>, "'Paul Mackerras'" <paulus@samba.org>,
       "'Pekka Enberg'" <penberg@cs.helsinki.fi>,
       "'Andrew Morton'" <akpm@osdl.org>, "'James Morris'" <jmorris@namei.org>,
       dwalker@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
In-Reply-To: <444A8335.6030407@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0604222216020.14748@yvahk01.tjqt.qr>
References: <001b01c66642$0abdbf80$0200a8c0@nuitysystems.com>
 <444A8335.6030407@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I don't actually like kfree(NULL) any time except error paths. It is
>> > subjective, not crazy talk.
>> 
>> Documented interface is not subjective.
>
> That's great. I don't know quite how to reply, or even if I should
> if you don't read what I write.

Where's the problem, if a developer does not know whether an object is NULL 
or not, he may call kfree(). If, on the other hand, he is sure it is NULL, 
there is no need to refree it, and if he is sure it is non-NULL, he can 
directly call __kfree(). So the readability can never suffer - you never 
need an if(x==NULL) anymore.


Jan Engelhardt
-- 
