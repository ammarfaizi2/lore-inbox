Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbTIALHZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 07:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTIALHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 07:07:25 -0400
Received: from smtp1.cwidc.net ([154.33.63.111]:14738 "EHLO smtp1.cwidc.net")
	by vger.kernel.org with ESMTP id S262826AbTIALHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 07:07:24 -0400
Message-ID: <3F5327E7.7040303@tequila.co.jp>
Date: Mon, 01 Sep 2003 20:05:11 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test4 and Xfree 4.3 and japanese 106 keyboard
References: <3F4C6281.90501@tequila.co.jp>
In-Reply-To: <3F4C6281.90501@tequila.co.jp>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Clemens Schwaighofer wrote:

> Hi,
>
> since in the 2.6 tree the keyboard layout changed there are several
> (well known and discussed) issues with the japanese keyboard layout and
> the Yen/bar(pipe) key. I can ship around that problem in the shell with
> 'setkeycodes 0x6a 124', but in Xfree the xmodmap doesn't take this over
> of course. The whole box was compiled against a 2.4.20-ck6.
>
> So my question is: do I have to recompiled XFree against the 2.6
> sources, or is there any XFree keymap changes I can do to get the
> Yen/bar key back?

well, just for the archives, if anybody else needs that:

in /usr/lib/X11/xkb/keycodes/xfree86 change the <AE13> = 133; to <AE13>
= 245; and either run xmodmap -e 'keycodes 245 = 0x5c 0x7c' or add the
xmodmap in the .xinitrc

I don't have the keycode for the "close japanese bracket and long
hyphen", so it is just a fix/hack, so you can youse tha backslash / bar
key on a jp106 (japanese keyboard) with 2.6.0-test kernels

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/UyfmjBz/yQjBxz8RAnnyAJ0UyrW1hNu8DS7rEFVQu/2u8K1wPQCgmDJp
9hrU1ib3hzv4yR/wq6gVPUo=
=a8OC
-----END PGP SIGNATURE-----

