Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVGEQrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVGEQrS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 12:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVGEQrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 12:47:18 -0400
Received: from dsl081-242-086.sfo1.dsl.speakeasy.net ([64.81.242.86]:42635
	"EHLO lapdance.christiehouse.net") by vger.kernel.org with ESMTP
	id S261931AbVGEQkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 12:40:55 -0400
Message-ID: <42CAB7E6.7050604@waychison.com>
Date: Tue, 05 Jul 2005 12:40:06 -0400
From: Mike Waychison <mike@waychison.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>
Subject: Re: ALPS psmouse_reset on reconnect confusing Tecra M2
References: <42C9A69A.5050905@waychison.com> <200507041705.17626.dtor_core@ameritech.net>
In-Reply-To: <200507041705.17626.dtor_core@ameritech.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dmitry Torokhov wrote:
> On Monday 04 July 2005 16:14, Mike Waychison wrote:
> 
>>Hi,
>>
>>I just upgrade my Tecra M2 this weekend to the latest GIT tree and
>>noticed that my mouse pointer/touchpad is now broken on resume.
>>
>>Investigating, it appears that mouse device gets confused due to the
>>introduced psmouse_reset(psmouse) during reconnect:
>>
>>http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f3a5c73d5ecb40909db662c4d2ace497b25c5940
> 
> 
> Hi,
> 
> Please try the following patch:
> 
> 	http://www.ucw.cz/~vojtech/input/alps-suspend-typo
>  
>

Yup.  This did the trick :D

Thanks,

Mike Waychison
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCyrfldQs4kOxk3/MRAs6CAJwMeMy8uZK3wVxwptihGtyRQUKVPQCaAnSO
XP1TQKemZRAbwiy/0UovARM=
=YVQS
-----END PGP SIGNATURE-----
