Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261373AbSIZQ5m>; Thu, 26 Sep 2002 12:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbSIZQ5m>; Thu, 26 Sep 2002 12:57:42 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:10372 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261373AbSIZQ5l> convert rfc822-to-8bit; Thu, 26 Sep 2002 12:57:41 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Updated to kernel 2.4.19 and now ipchains and iptables are broke.
Date: Thu, 26 Sep 2002 19:02:47 +0200
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: "Nathan" <etherwolf@sopris.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209261901.17679.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

> This is surely the greenest of green questions (sorry), but I finally got my
> kernel re-compiled the way I want it using the 2.4.19 sources from
> kernel.org. It loads, seems to be working fine, except ipchains and
> iptables... ipchains insists that it is incompatible with my kernel, and
> iptables isn't sure what's going on but it thinks maybe something (. Well 
> fine. I downloaded the latest versions of ipchains/tables from rpmfind and
> upgraded, same thing.

"Incompatible with this kernel" for ipchains seems so that you have compiled 
Netfilter stuff into your kernel.

"itself or the kernel needs upgrading" for iptables seems so that you either 
haven't compiled netfilter as module(s) or static into the kernel and forgot 
something in the kernel config.

> I haven't been able to find any actual solutions off google for this... a
> few people mention the same problem but no fixes. Can someone point this
> rookie in the right direction to fix my packet filters? :-)
Check your kernel config. "make menuconfig" or "xconfig" and goto:

Networking options  --->
  IP: Netfilter Configuration  --->

and look if you did it properly.

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
