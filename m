Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265135AbUGCO4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265135AbUGCO4u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 10:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbUGCO4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 10:56:50 -0400
Received: from aun.it.uu.se ([130.238.12.36]:57777 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265135AbUGCO4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 10:56:48 -0400
Date: Sat, 3 Jul 2004 16:56:40 +0200 (MEST)
Message-Id: <200407031456.i63EueJU023103@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: Re: [PATCH][2.6.7-mm5] perfctr low-level documentation
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jul 2004 03:34:13 -0700, Andrew Morton wrote:
>Mikael Pettersson <mikpe@csd.uu.se> wrote:
>>
>> On Fri, 2 Jul 2004 15:44:14 -0700, Andrew Morton wrote:
>> >Mikael Pettersson <mikpe@csd.uu.se> wrote:
>> >>
>> >> I'm
>> >> considering Christoph Hellwig's suggestion of moving
>> >> the API back to /proc/<pid>/, but with multiple files
>> >> and open/read/write/mmap instead of ioctl. I believe I
>> >> can make that work, but it would take a couple of days
>> >> to implement properly. Please indicate if you would like
>> >> this change or not.
>> >
>> >What would be the advantages of such a change?
>> 
>> Eliminating the 6 or so new syscalls I was forced
>> to add when nuking the old ioctl() API.
>
>syscalls are cheap.
>
>> There would be a /proc/<pid>/<tid>/perfctr/ directory
>> with files representing the control data, counter
>> state, general info, and auxiliary control ops.
>
>Futzing around with /proc handlers and mmapping /proc files doesn't sound
>very attractive.  Unless we have some solid reason for changing things
>I'd be inclined to leave it as-is.  Do you agree?

My only reason was to avoid complaints about adding
syscalls when other interfaces could be made to work.
There are no technical reasons for preferring files
under /proc, in fact it would burden user-space with
having to maintain more state (full path + several
open file descriptors instead of a single fd).

As long as you and Linus don't mind the new syscalls,
I'm happy staying with the current API. I'll start
working on the high-level API documentation then.

/Mikael
