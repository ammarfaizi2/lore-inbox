Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVETUSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVETUSK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 16:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVETUSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 16:18:10 -0400
Received: from alog0356.analogic.com ([208.224.222.132]:25025 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261354AbVETUSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 16:18:04 -0400
Date: Fri, 20 May 2005 16:17:43 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Screen regen buffer at 0x00b8000
In-Reply-To: <Pine.LNX.4.58.0505201259560.2206@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0505201612360.6833@chaos.analogic.com>
References: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com>
 <Pine.LNX.4.58.0505201259560.2206@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2005, Linus Torvalds wrote:

>
>
> On Fri, 20 May 2005, Richard B. Johnson wrote:
>>
>> Why can't I consistantly write to the VGA screen regen buffer
>> and have it appear on the screen????
>
> Don't do it.
>

Well I started out opening /dev/vcs, lseeking to 64, and writing
a string. This "sort of" worked, but screen attributes got messed
up so the "blue" screen attribute 0x17 ended up eventually being
black.

So, I decided to directly write. It doesn't work as you explain
because hardware scroll is being used.

>
> Anyway, you really _really_ shouldn't do anything like this in the first
> place.
>
> 		Linus
>

Yes, and I didn't want to. However a customer wants some status to
be always displayed in the upper-right-hand corner of a 4x5 LCD
with a tiny CPU board.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5554.17 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
