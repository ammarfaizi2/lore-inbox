Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265657AbSJSSqs>; Sat, 19 Oct 2002 14:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265658AbSJSSql>; Sat, 19 Oct 2002 14:46:41 -0400
Received: from mtao-m01.ehs.aol.com ([64.12.52.73]:38108 "EHLO
	mtao-m01.ehs.aol.com") by vger.kernel.org with ESMTP
	id <S265657AbSJSSqj>; Sat, 19 Oct 2002 14:46:39 -0400
Date: Sat, 19 Oct 2002 11:52:31 -0700
From: "John G. Myers" <jgmyers@netscape.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-reply-to: <005c01c2770e$ba9cf050$0e00000a@turchodog>
To: Tervel Atanassov <noxidog@earthlink.net>
Cc: "'Benjamin LaHaise'" <bcrl@redhat.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       "'linux-aio'" <linux-aio@kvack.org>
Message-id: <EBEB520C-E393-11D6-862F-000393439AB6@netscape.com>
MIME-version: 1.0
X-Mailer: Apple Mail (2.546)
Content-type: text/plain; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday, October 18, 2002, at 06:27  PM, Tervel Atanassov wrote:
>  The code you have
> below seems a bit awkward -- the line while(do_io(fd) != EAGAIN) 
> appears
> twice.  I think the reason for that is that you're trying to do too 
> many
> things at once, namely, you're trying to handle both the initial
> accept/setup of the socket and its steady state servicing.  I don't see
> any benefit to that -- it definitely doesn't make for cleaner code.  
> Why
> not do things separately.

If you carefully reread the message you replied to, you will see that 
this is exactly what I am proposing.  The redundant copy of the line 
you consider awkward would be removed.

