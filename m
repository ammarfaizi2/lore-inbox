Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVAZXnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVAZXnQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVAZXmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:42:54 -0500
Received: from alog0168.analogic.com ([208.224.220.183]:41856 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261769AbVAZSjr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 13:39:47 -0500
Date: Wed, 26 Jan 2005 13:39:03 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Olivier Galibert <galibert@pobox.com>
cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
In-Reply-To: <20050126183121.GA93329@dspnet.fr.eu.org>
Message-ID: <Pine.LNX.4.61.0501261338460.18301@chaos.analogic.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com>
 <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>
 <20050126181006.GA80759@dspnet.fr.eu.org> <Pine.LNX.4.61.0501261315220.18301@chaos.analogic.com>
 <20050126183121.GA93329@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005, Olivier Galibert wrote:

> On Wed, Jan 26, 2005 at 01:20:53PM -0500, linux-os wrote:
>> On Wed, 26 Jan 2005, Olivier Galibert wrote:
>>> Given that the man page itself says that unless you're using MAP_FIXED
>>> start is only a hint and you should use 0 if you don't care things can
>>> get real annoying real fast.  Imagine if you want to mmap a <4K file
>>> and mmap then returns 0, i.e. NULL, as the mapping address as you
>>> asked.  It's illegal from the point of view of susv3[1] and it's real
>>> annoying in a C/C++ program.
>>
>> mmap() can (will) return 0 if you use 0 as the hint and use MAP_FIXED
>> at 0. That's the reason why one does NOT check for NULL with mmap() but
>> for MAP_FAILED (which on this system is (void *)-1.
>
> All the paragraph was under an obvious "when you do not use MAP_FIXED"
> precondition.  The patch is not supposed to change anything to the
> MAP_FIXED case.  Malloc does not use MAP_FIXED.  Usual file mmaping
> as an alternative to read() does not use MAP_FIXED.
>
>  OG.

Okay. That's fine.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
