Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbULPVvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbULPVvp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 16:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbULPVvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 16:51:45 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:59583 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262037AbULPVvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 16:51:42 -0500
Date: Thu, 16 Dec 2004 16:51:18 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: debugfs in the namespace
In-reply-to: <20041216190835.GE5654@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Message-id: <41C20356.4010900@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan>
 <20041216190835.GE5654@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greg KH wrote:
> On Thu, Dec 16, 2004 at 11:00:02AM -0800, Pete Zaitcev wrote:
> 
>>Hi Greg,
>>
>>what is the canonic place to mount debugfs: /debug, /debugfs, or anything
>>else? The reason I'm asking is that USBMon has to find it somewhere and
>>I'd really hate to see it varying from distro to distro.
> 
> 
> Hm, in my testing I've been putting it in /dbg, but I don't like vowels :)
> 
> Anyway, I don't really know.  /dev/debug/ ?  /proc/debug ?  /debug ?
> 
> What do people want?  I guess it's time to write up a LSB proposal :(
> 

I thought debugfs was meant for just debugging.  As there is no plans
for standardizing its namespace, why are we allowing ourselves to rely
on it being mounted at all?

AFAICT, there should be no excuse for userspace to actually rely on any
of the data within debugfs.  Otherwise we end up with yet another
filesystem whose role is: Chaotic hodgepodge of magic files created by
drivers that couldn't bother to be well-organized.

Please, let's not make debugfs part of userspace.  Keep it for what it
is, debugging purposes only.


- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBwgNWdQs4kOxk3/MRAslqAJwPnra30/EBuZxuXkdpo67SZJXJUQCaAtC1
OeMH0Xiww/8xV9tIfqyzmE4=
=Aa8I
-----END PGP SIGNATURE-----
