Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbTDOMzY (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTDOMzY 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:55:24 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:50415 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S261359AbTDOMzX (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 08:55:23 -0400
Message-ID: <3E9C03DD.3040200@oracle.com>
Date: Tue, 15 Apr 2003 15:06:37 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030409
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florin Iucha <florin@iucha.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server terminates
References: <20030415133608.A1447@cuculus.switch.gts.cz> <20030415125507.GA29143@iucha.net>
In-Reply-To: <20030415125507.GA29143@iucha.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florin Iucha wrote:
> On Tue, Apr 15, 2003 at 01:36:09PM +0200, Petr Cisar wrote:
> 
>>Hello
>>
>>Since 2.5.60, I have been experiencing problems with a complete system freeze or random oopses when the X-server terminates. It is happening on both machines I am using whose hardware configuration differs slightly, however both of them are equipped with ATI video cards (ATI Rage 128 and ATI Radeon 8500), and both of them run the same version of X-server. That's about all they have in common.
>>
>>The version of X-server I am using is:
>>XFree86 Version 4.3.0
>>Release Date: 27 February 2003
>>
>>Since the crash either results in an oops obviously not having to do with the core problem, or the system freezes dead (no ping, no reaction to SysRq key), I don't know how to get some debug information to describe the fault more precisely.
>>
>>Has anyone notyiced similar problems and is there some documentation how to trace such deadly bugs ?
> 
> 
> I got the same problem here:
>    AMD Duron 1.2
>    SIS 735 chipset
>    ATI Radeon 8500
> 
> On 2.5.67 I get freezes with XFree86 4.3.0 . It works fine with 4.2.1 .
> 
> Exactly the same symptoms: the box is dead, no message on the serial
> console.
> 
> florin

According to http://bugme.osdl.org/show_bug.cgi?id=543 , a variant
  of the problem happens by just exiting from Gnome and running startx
  again.

I surely hit bug 543 in 2.5.65 IIRC, and guess what...
  ATI Radeon 7500 Mobile - XFree 4.2.1

According to other emails on lkml, it appears that DRM and/or AGP
  new kernel code might be at fault. I don't actually remember
  seeing non-Radeon cards being hit by such problems though...

When the ex-PC from my brother is supplied a new USB keyboard and
  a hard disk I'll try reproducing on its Voodoo5 :)

--alessandro

  "Se e' vero che ad ogni rinuncia corrisponde una contropartita considerevole
    privarsi dell'anima comporterebbe una lauta ricompensa"
       (Carmen Consoli, "L'eccezione")

