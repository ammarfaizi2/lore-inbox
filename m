Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266746AbSKUPaO>; Thu, 21 Nov 2002 10:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266749AbSKUPaO>; Thu, 21 Nov 2002 10:30:14 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:55558 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S266746AbSKUPaN>; Thu, 21 Nov 2002 10:30:13 -0500
Message-Id: <200211211517.gALFHPp26516@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Mark Mielke <mark@mark.mielke.cc>,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Date: Thu, 21 Nov 2002 18:08:16 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021120235135.GA32715@mark.mielke.cc> <Pine.LNX.4.44.0211201546250.974-100000@blue1.dev.mcafeelabs.com> <20021121003332.GE32715@mark.mielke.cc>
In-Reply-To: <20021121003332.GE32715@mark.mielke.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 November 2002 22:33, Mark Mielke wrote:
> On Wed, Nov 20, 2002 at 03:57:26PM -0800, Davide Libenzi wrote:
> > > What were you thinking? 1X64 bit or 2X32 bit?
> >
> > typedef union epoll_obj {
> > 	void *ptr;
> > 	__uint32_t u32[2];
> > 	__uint64_t u64;
> > } epoll_obj_t;
> > I'm open to suggestions though. The "ptr" enable me to avoid wierd
> > casts to avoid gcc screaming.
>
> It looks fine to me for as long as we can guarantee that sizeof(void
> *) will be less than or equal to sizeof(__uint64_t) (relatively
> safe).
>
> I still prefer 'userdata' over 'obj', but the name of thing is not
> very important to me.
>
> I'm not sure if this is wise or not, but an 'fd' member might be
> useful as well:
>
>   typedef union epoll_obj {
>   	void *ptr;
>         int fd;
>   	__uint32_t u32[2];
>   	__uint64_t u64;
>   } epoll_obj_t;

u32 and u64 sounds more like type name. d32 / d64 ?
--
vda
