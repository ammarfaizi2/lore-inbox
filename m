Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266841AbSKUQh2>; Thu, 21 Nov 2002 11:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266842AbSKUQh2>; Thu, 21 Nov 2002 11:37:28 -0500
Received: from adedition.com ([216.209.85.42]:49669 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S266841AbSKUQh1>;
	Thu, 21 Nov 2002 11:37:27 -0500
Date: Thu, 21 Nov 2002 11:51:02 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021121165102.GA5315@mark.mielke.cc>
References: <20021120235135.GA32715@mark.mielke.cc> <Pine.LNX.4.44.0211201546250.974-100000@blue1.dev.mcafeelabs.com> <20021121003332.GE32715@mark.mielke.cc> <200211211517.gALFHPp26516@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211211517.gALFHPp26516@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 06:08:16PM -0200, Denis Vlasenko wrote:
> >   typedef union epoll_obj {
> >   	void *ptr;
> >         int fd;
> >   	__uint32_t u32[2];
> >   	__uint64_t u64;
> >   } epoll_obj_t;
> u32 and u64 sounds more like type name. d32 / d64 ?

d32 isn't as descriptive as u32 (unsigned). Also if every field had a 'd'
in front of it, it would be 'dptr', 'dfd', ...

u32 is fine to me.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

