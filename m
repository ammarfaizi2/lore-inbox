Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbVA0T6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVA0T6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 14:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbVA0T5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 14:57:42 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:62110 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262718AbVA0T5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 14:57:08 -0500
Message-ID: <41F947A9.8060800@comcast.net>
Date: Thu, 27 Jan 2005 14:57:29 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Julien TINNES <julien.tinnes.NOSPAM@francetelecom.REMOVE.com>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Patch 0/6  virtual address space randomisation
References: <20050127101117.GA9760@infradead.org>	 <41F8D44D.9070409@francetelecom.REMOVE.com> <1106827050.5624.81.camel@laptopd505.fenrus.org> <41F927F2.2080100@comcast.net> <41F9425A.2030101@francetelecom.REMOVE.com>
In-Reply-To: <41F9425A.2030101@francetelecom.REMOVE.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Julien TINNES wrote:
> 
>>
>> Yeah, if it came from PaX the randomization would actually be useful.
>> Sorry, I've just woken up and already explained in another post.
>>
> 
> Please, no hard feelings.
> 
> Speaking about implementation of the non executable pages semantics on
> IA32, PaX and Exec-Shield are very different (well not that much since
> 2.6 in fact because PAGEEXEC is now "segmentation when I can").
> But when it comes to ASLR it's pretty much the same thing.
> 
> The only difference may be the (very small) randomization of the brk()
> managed heap on ET_EXEC (which is probably the more "hackish" feature of
> PaX ASLR) but it seems that Arjan is even going to propose a patch for
> that (Is this in ES too ?).
> 
> I think it's a great opportunity here to get the same basis for ASLR in
> PaX and ES merged into the vanilla kernel.
> If it's only a matter of changing the number of randomized bits in an
> additional PaX patch, it's no problem! It's more important to have a
> correct basis, focus on that.
> 

I'm not at all familiar with the code, though PaX uses more fine-grained
binary markings in PT_PAX_FLAGS (requires a patched binutils, though I
guess a PaX system could just nuke PT_GNU_STACK from .load and replace
it with PT_PAX_FLAGS).  *shrug*

. . . ok so I've hacked at PaX' source a few times for fun, but I forgot
everything I saw, I swear. :)

whatever, at this point I've lost interest, as I'm starting to wonder
where my next meal will come from.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD4DBQFB+UeohDd4aOud5P8RAra3AJsEs0fJiQvqbp45ySUbUQT/TJkDRACYoYzq
nzy0VdUXiT84DEzzkPDVVQ==
=exFr
-----END PGP SIGNATURE-----
