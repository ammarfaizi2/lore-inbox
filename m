Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316655AbSE3OOi>; Thu, 30 May 2002 10:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316656AbSE3OOh>; Thu, 30 May 2002 10:14:37 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:10501 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S316655AbSE3OOg>; Thu, 30 May 2002 10:14:36 -0400
Message-ID: <3CF6342D.7060905@loewe-komp.de>
Date: Thu, 30 May 2002 16:16:13 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: missing bit from signal patches
In-Reply-To: <20020530220828.3c3192cd.sfr@canb.auug.org.au> <20020530232636.09d7b7eb.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> Hi Roman,
> 
> On Thu, 30 May 2002 14:46:20 +0200 (CEST) Roman Zippel <zippel@linux-m68k.org> wrote:
> 
>>On Thu, 30 May 2002, Stephen Rothwell wrote:
>>
>>
>>>Is the following a more ugly hack than yours?
>>>
>>Yes. :)
>>The problem is copy_siginfo(), which wants to access struct siginfo.
>>Copy the m68k version of siginfo.h and try to compile that.
>>
> 
> OK, sorry, brain fart :-)
> 
> It seems that is an architecture defines its own siginfo_t then it must
> also define its own copy_siginfo function (for now anyway).
> 
> Try this ...
> 

Why is that done so complicated?
Why not just copy the struct over?
When the kernel generates the signal, I hope the mem is zeroed
and we copy it to user. When a user sends a signal, you want to
prevent sending of arbitrary data? Why is that not done where
the permission check happens?

What do I miss?







