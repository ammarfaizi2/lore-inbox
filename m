Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261254AbREOS5t>; Tue, 15 May 2001 14:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261261AbREOS5j>; Tue, 15 May 2001 14:57:39 -0400
Received: from geos.coastside.net ([207.213.212.4]:56741 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261254AbREOS51>; Tue, 15 May 2001 14:57:27 -0400
Mime-Version: 1.0
Message-Id: <p05100314b72729920e83@[207.213.214.37]>
In-Reply-To: <Pine.LNX.4.33.0105151911410.730-100000@mikeg.weiden.de>
In-Reply-To: <Pine.LNX.4.33.0105151911410.730-100000@mikeg.weiden.de>
Date: Tue, 15 May 2001 11:57:14 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] Remove silly beep macro from pgtable.h
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7:36 PM +0200 2001-05-15, Mike Galbraith wrote:
>On Tue, 15 May 2001, Jeff Golds wrote:
>
>>  Hi folks,
>>
>>  Found this bit of unused code in the i386 and sh architectures. 
>>As it's not being used, let's get rid of it.  Also, pgtable.h seems 
>>to be an odd place for this.
>
>I'd leave it.. folks with early boot troubles might find it useful.
>
>	-Mike

Consider small rant about literal IO references to magic locations 
hereby ranted. Especially in header files completely unrelated to the 
IO function in question.

-#define __beep() asm("movb $0x3,%al; outb %al,$0x61")

Let's please not assume that every i386 implementation has a full set 
of legacy PC IO hardware.
-- 
/Jonathan Lundell.
