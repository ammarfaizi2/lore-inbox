Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbVJSEYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbVJSEYq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 00:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbVJSEYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 00:24:46 -0400
Received: from rwcrmhc14.comcast.net ([204.127.198.54]:45458 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751467AbVJSEYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 00:24:45 -0400
Message-ID: <4355C9F3.40004@comcast.net>
Date: Wed, 19 Oct 2005 00:22:11 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: Jeff Bailey <jbailey@ubuntu.com>, linux-kernel@vger.kernel.org,
       ubuntu-devel <ubuntu-devel@lists.ubuntu.com>
Subject: Re: Keep initrd tasks running?
References: <4355494C.5090707@comcast.net> <1129663759.18784.98.camel@localhost.localdomain> <4355BEF4.8000800@cfl.rr.com>
In-Reply-To: <4355BEF4.8000800@cfl.rr.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Phillip Susi wrote:
> I am confused.  I thought that once the initramfs init execs the real
> init, the initramfs is freed.  It can't be freed if there are processes
> that still have open files there, so that would seem to prevent any
> processes being started in the initramfs and continuing after the real
> system is booted.
> 

AFAIK it's pivoted and then umounted, which frees it.  This doesn't mean
it has to be freed..  . .

> Jeff Bailey wrote:
> 
>> This is much more easily supported in Breezy.  usplash is started at the
>> top of the initramfs (from the init-top hook) and lives until we start
>> gdm.
>>
>> The biggest constraint is that you don't have write access to the target
>> root filesystem (since it's mounted readonly).  However, /dev is a tmpfs
>> that is move mounted to the new root system.  If you need to have
>> sockets open or store data, you can use that.  usplash does this for its
>> socket.
>>
>> Note that the initramfs startup sequence isn't at all similar to the old
>> initrd startups.  It should be easy for you to cleanly add what you want
>> under /etc/mkinitramfs/scripts and not have to modify the
>> initramfs-tools package.  /usr/share/doc/initramfs-tools/HACKING
>> contains some starter information.
>>
>> Hope this helps!
>>
>> Tks,
>> Jeff Bailey
>>
>>
>>
>>
>>
>>  
>>
> 
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDVcnzhDd4aOud5P8RAmk/AJ48RK9V5CrJeNXu/ORxuNa3I/+jrACeOkUl
z2l1tNTWm6dtjysddaZ81co=
=7GLq
-----END PGP SIGNATURE-----
