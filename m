Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315525AbSECB3K>; Thu, 2 May 2002 21:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315527AbSECB3J>; Thu, 2 May 2002 21:29:09 -0400
Received: from zok.SGI.COM ([204.94.215.101]:60593 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315525AbSECB3J>;
	Thu, 2 May 2002 21:29:09 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: module choices affecting base kernel size??? 
In-Reply-To: Your message of "Thu, 02 May 2002 20:57:40 -0400."
             <Pine.LNX.4.44.0205022054160.8024-100000@conn6m.toms.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 11:28:57 +1000
Message-ID: <3271.1020389337@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002 20:57:40 -0400 (EDT), 
Tom Oehser <tom@toms.net> wrote:
>
>> Tom Oehser <tom@toms.net> wrote:
>> >Changing all =m to =n in my config makes a 4K difference in the kernel size.
>
>On Fri, 3 May 2002, Keith Owens wrote:
>
>> The majority of modules have no effect on kernel size but some modules
>> require base kernel code as well.  This is typically common code or low
>> level setup functions.  You will find that those modules will not load
>> now or will break.
>
>Great.  I must have missed the list of exactly *which* modules do this...
>
>Any ideas on a reasonable way of how to identify them?

Not easy.  Some of it is in the Makefiles, some of it is in the code.
Looking for conditional EXPORT_SYMBOLS() will find some of the extra
space, I don't know of any way of finding all of the extra code/data,
apart from compiling and measuring.

