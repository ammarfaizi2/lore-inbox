Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTEULZr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 07:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbTEULZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 07:25:47 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:8186 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262056AbTEULZq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 07:25:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: David Balazic <david.balazic@uni-mb.si>, linux-kernel@vger.kernel.org
Subject: Re: Wrong clock initialization
Date: Wed, 21 May 2003 06:38:19 -0500
X-Mailer: KMail [version 1.2]
References: <3ECA673F.7B3FB388@uni-mb.si>
In-Reply-To: <3ECA673F.7B3FB388@uni-mb.si>
MIME-Version: 1.0
Message-Id: <03052106381900.03186@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 May 2003 12:34, David Balazic wrote:
> Hi!
>
> When the kernel is booted ( ia32 version at least ) , it reads
> the time from from the hardware CMOS clock , _assumes_ it is in
> UTC and set the system time to it.
>
> As almost nobody runs their clock in UTC, this means that the system
> is running on wrong time until some userspace tool corrects it.
>
> This can lead to situtation when time goes backwards :
>
> timezone is 2hours east of UTC.
> UTC time : 20:00
> local time : 22:00
>
> System time between boot and userspace fix : 22:00UTC
> System time after fix : 20:00UTC
>
> Comments ?

I strongly recommend running in UTC.

1. the system can then move between time zones without additional complexity
2. conversion errors during localtime -> system time don't occur
3. your clock doesn't get blown during system->localtime during shutdown
   (assuming you save system time...)
4. if you operate in a daylight saving time area, you won't get your clock
   blowin by variations in time depending on when you reboot.
