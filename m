Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbUBNUmO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 15:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUBNUmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 15:42:14 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:4881 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263607AbUBNUmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 15:42:10 -0500
From: vda@port.imtp.ilyichevsk.odessa.ua
To: ross@datscreative.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 Paging Fault, Cache tries to swap with no swap partition
Date: Sat, 14 Feb 2004 22:33:23 +0200
User-Agent: KMail/1.5.4
References: <200402150306.35704.ross@datscreative.com.au>
In-Reply-To: <200402150306.35704.ross@datscreative.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402142233.23740.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 February 2004 19:06, Ross Dickson wrote:
> I have an imaging system writing files to removable hard drives.
> Compact Flash boot with ram drives so I usually have no swap partition or
> file.
>
> Recently I upgraded kernel from 2.4.20 to 2.4.24.
>
> System has "mem=460M" (512M ram fitted) and starts with about
> 400M free. After recording for a while the Cached ram acquires all
> but about 4Mb MemFree.
>
> On a hot 38C day it started Oops'ing re paging memory. It runs the

Too vague.
Do you have any logging? At least a circular buffer? Anything?

> same 2 programs all day gathering and compressing images.
> Sorry I have no detail on the Oops at the moment, computer is in a vehicle
> and does not normally have a screen. From memory it couldn't allocate a
> virtual page.
>
> I found if I put in a 16Mb ram drive as swap then it would grab
> roughly 1.4Mb of it on occasion and keep it until recording stopped
> for a while. SwapCached is either 0Kb or 1024Kb, not anything else.

If swap is active, some of it may be used even when box is not
heavily loaded. That's normal.

> Is this behaviour expected - to require a swap file?

No.

> Can the paging cache be tuned in /proc or somewhere to prevent it being so
> greedy as to want more memory than the machine has?

Maybe. But you should concentrate on finding where exactly it oopsed.

> Is the quickest fix to give it more ram. I read on another posting that
> with greater than 512Mb the cache won't grab any more?

Please don't succumb to 'add more RAM' syndrome. 460 megs should be fine
for you. I'd say better find the root of the problem.
--
vda

