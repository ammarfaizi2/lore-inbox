Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWB1MSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWB1MSe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWB1MSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:18:34 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:23521 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932204AbWB1MSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:18:33 -0500
Message-ID: <44043F8C.7070500@comcast.net>
Date: Tue, 28 Feb 2006 07:18:20 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Memory compression (again). . help?
References: <4403A14D.4050303@comcast.net> <4403CAE9.5020007@ums.usu.ru>
In-Reply-To: <4403CAE9.5020007@ums.usu.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Alexander E. Patrakov wrote:
> John Richard Moser wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> I'm not quite sure what I'm doing or when I have time, but I'm looking
>> into writing in some hooks and a compression routine to manage
>> compressed memory.  I have the following considerations:
>>
>>  - Compressed memory should become "Swap."  This means the kernel would
>>    report memory used for compressed storage as used swap.  At boot it
>>    would reflect 0K swap; when there are 1024KiB of pages compressed in
>>    memory, 1024KiB of additional "swap" is reported, all used.
>>  - I need to stop the kernel when it's about to swap.  This should be
>>    done when it's decided that either invalidating disk cache or
>>    swapping is the best course of action, and what to do with what.  At
>>    this point I'll have to be able to see what the kernel wants to swap
>>    out and tell it that it's taken care of.
>>  - I need to catch invalid pagefaults that look for swap, as well as the
>>    disk cache mechanism.  I'll be adding stuff to compress disk cache,
>>    so disk cache might need to be "swapped in" effectively.
> 
> If you are OK with using a ery old 2.4.18 kernel, look at
> http://linuxcompressed.sourceforge.net/
> 

I'm actually looking to submit to mainline in the end ;P  It'd be a very
good permenant feature.  RAM is cheap, but CPU is even cheaper; if I buy
a gig of RAM and get 200M free, woohoo?

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                                     -- Evil alien overlord from Blasto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEBD+KhDd4aOud5P8RAmAjAJ9RvbX1WxtHNDWWJy2LD33ll2JuyQCfefQ/
DbvWtgSk5sE2Uhuge1jvB5M=
=Gbdm
-----END PGP SIGNATURE-----
