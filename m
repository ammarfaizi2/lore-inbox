Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbVCVFUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbVCVFUQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVCVFRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 00:17:12 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:15365 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S262420AbVCVFPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 00:15:45 -0500
Message-ID: <423F9256.10606@lougher.demon.co.uk>
Date: Tue, 22 Mar 2005 03:34:46 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Paulo Marques <pmarques@grupopie.com>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
References: <20050314170653.1ed105eb.akpm@osdl.org> <A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk> <20050314190140.5496221b.akpm@osdl.org> <423727BD.7080200@grupopie.com> <20050321101441.GA23456@elf.ucw.cz> <423EEEC2.9060102@lougher.demon.co.uk> <20050321190044.GD1390@elf.ucw.cz> <423F0C67.6000006@lougher.demon.co.uk> <20050321224937.GQ1390@elf.ucw.cz>
In-Reply-To: <20050321224937.GQ1390@elf.ucw.cz>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>Perhaps squashfs is good enough improvement over cramfs... But I'd
>>>like those 4Gb limits to go away.
>>
>>So would I.  But it is a totally groundless reason to refuse kernel 
>>submission because of that, Squashfs users are quite happily using it 
>>with such a "terrible" limitation.  I'm asking for Squashfs to be put in 
>>the kernel _now_ because users are asking me to do it _now_.  If it 
> 
> 
> Putting it into kernel because users want it is... not a good
> reason. You should put it there if it is right thing to do. I believe
> you should address those endianness issues and drop V1 support. If
> breaking 4GB limit does not involve on-disk format change, it may be
> okay to merge. After code is merged, doing format changes will be
> hard...
> 
> 								Pavel

So users don't matter anymore, now that's a terrible admission to make. 
  Linux wouldn't be where it is today without all those "mere" users.

I obviously think putting Squashfs into the kernel is the right thing to do.

The filesystem is endian safe and has been since the first release - it 
works on big endian and little endian, and every architecure I've tried 
it on it works (Intel 32/64, PowerPC 32/64. MIPS, ARM, Sparx).  The 
endian code which everyone seems to have got so worked up about is there 
to _make_ it endian safe.  I've already explained why making Squashfs 
natively support both little endian and big endian is important for 
embedded systems.

I have agreed to drop V1.0 support, and yes (as explained in another 
emauil), breaking the 4GB limit does involve on-disk format change.
