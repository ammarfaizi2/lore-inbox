Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVBGOrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVBGOrs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVBGOro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:47:44 -0500
Received: from alog0411.analogic.com ([208.224.222.187]:4224 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261443AbVBGOqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:46:37 -0500
Date: Mon, 7 Feb 2005 09:46:31 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org
Subject: Re: Reading Bad DVD Under 2.6.10 freezes the box.
In-Reply-To: <1107783980.6191.154.camel@gonzales>
Message-ID: <Pine.LNX.4.61.0502070939320.21570@chaos.analogic.com>
References: <Pine.LNX.4.62.0502070728520.1743@p500> 
 <Pine.LNX.4.61.0502070757580.21063@chaos.analogic.com> <1107783980.6191.154.camel@gonzales>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-42337991-1107787591=:21570"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-42337991-1107787591=:21570
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 7 Feb 2005, Xavier Bestel wrote:

> Le lundi 07 f=FF=FFvrier 2005 =FF=FF 08:05 -0500, linux-os a =FF=FFcrit :
>
>>> Main Question >> Why does Linux 'freeze up' when W2K gives a BadCRC err=
or msg
>>> (never freezes)?
>>
>> Of course it should not. However, there were many incomplete changes
>> made in 2.6.nn and some may involve problems with locking, etc.
>
> I don't remember a version of the kernel gracefully handling scratched
> CD/DVD.
>
> =09Xav
>

Well `cdparanoia` will read, analyze/rip, and reject trashed CDs
without ever hanging the Linux-2.4.22 kernel, but will immediately
hang linux-2.6.10.

Basically, when you start getting the kernel error messages on
linux-2.4.22, you can ^C out and everything will quiet down.
With Linux-2.6.10, nothing entered from the keyboard will
do anything. Since the Caps-Lock key still functions, interrupts
are still active. However, it is likely the kernel-lock that
prevents signals (like ^C or ^/) from being executed.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-42337991-1107787591=:21570--
