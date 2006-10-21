Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992913AbWJULCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992913AbWJULCA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 07:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992925AbWJULCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 07:02:00 -0400
Received: from host106-7.junet.se ([193.11.106.7]:971 "EHLO smtp.azoff.se")
	by vger.kernel.org with ESMTP id S2992913AbWJULB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 07:01:59 -0400
Message-ID: <4539FE18.8090205@azoff.se>
Date: Sat, 21 Oct 2006 13:01:44 +0200
From: =?UTF-8?B?VG9yYmrDtnJuIFN2ZW5zc29u?= <lkml@azoff.se>
User-Agent: Thunderbird 1.5.0.7 (X11/20060920)
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, grsecurity@grsecurity.net
Subject: Re: ext3 oops with 2.4.33.3-grsec
References: <45379EBE.4050906@azoff.se> <20061021071138.GA1709@1wt.eu>
In-Reply-To: <20061021071138.GA1709@1wt.eu>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello!

Willy Tarreau wrote:
> I see nothing between 2.4.33 and 2.4.33.3 which affects ext3 in any way.
> The "ud2a" you see in the decoded oops is a call to 'BUG()'. The only
> one I find in ext3 is in ext3_write_super() which is not called from
> any function in your trace. I do not notice any other relevant ones in
> inline functions included from other files. Could you check if the
> grsec patch you use changes anything in fs/ext3/super.c ? It will make
> the debugging easier.

No, nothing. I have put the grsec-patch I used on my httpd[0]. Could I
have got my journal corupted in someway during the random reboots? Could
it help to recreate a journal and if so, how do I do that?

[0]
http://www.azoff.se/error/debian/oops/grsecurity-2.1.9-2.4.33.3-200609031224.patch.gz


- --
> Torbjörn Svensson <lkml (at) azoff (dot) se>
> Please CC me as I am not subscribed to the list!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFOf4TeY7jmtvbDP0RAuoiAKCbX3uoh37CM5+PYE8pBXcnYA6hUgCfZnB3
guUbELQofgZwRrawrbrsCKE=
=WJeZ
-----END PGP SIGNATURE-----
