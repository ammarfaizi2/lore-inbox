Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263870AbSITVhE>; Fri, 20 Sep 2002 17:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263874AbSITVhE>; Fri, 20 Sep 2002 17:37:04 -0400
Received: from 213-152-55-49.dsl.eclipse.net.uk ([213.152.55.49]:16045 "EHLO
	monkey.daikokuya.co.uk") by vger.kernel.org with ESMTP
	id <S263870AbSITVhE>; Fri, 20 Sep 2002 17:37:04 -0400
Date: Fri, 20 Sep 2002 22:41:38 +0100
From: Neil Booth <neil@daikokuya.co.uk>
To: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
Cc: jt@hpl.hp.com, Jeff Garzik <jgarzik@mandrakesoft.com>,
       thunder@lightweight.ods.org, linux-kernel@vger.kernel.org
Subject: Re: FW: 2.5.34: IR __FUNCTION__ breakage
Message-ID: <20020920214138.GA9638@daikokuya.co.uk>
References: <20020920171901.GG8260@bougret.hpl.hp.com> <Pine.BSF.4.44.0209202006040.13460-100000@e0-0.zab2.int.zabbadoz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.44.0209202006040.13460-100000@e0-0.zab2.int.zabbadoz.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjoern A. Zeeb wrote:-

> > > Also, specifically relating to varargs macros as described above, you
> > > can certainly have a varargs macro with zero args, just look at C99
> > > varargs macros...
> >
> > 	I remember that it didn't work. Ok, I'll try again.
> 
> if I remember corretly with C99 if you do s.th. like this (simple
> sample):
> 
> #define LOG(level, format, ...)					\
>                 log(level, format, ##__VA_ARGS__);

No, this is only valid C99 if __VA_ARGS__ is the empty list.

I posted the correct way to write this macro about a week ago that
works with all versions of GCC (and follows their documented
behaviour; this stuff *is* all documented).

Neil.
