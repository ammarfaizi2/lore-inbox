Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264849AbUEYNun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264849AbUEYNun (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 09:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbUEYNun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 09:50:43 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:6362 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S264849AbUEYNub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 09:50:31 -0400
Message-ID: <40B34F1E.5020206@free.fr>
Date: Tue, 25 May 2004 15:50:22 +0200
From: baptiste coudurier <baptiste.coudurier@free.fr>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: MORE THAN 10 IDE CONTROLLERS
References: <40B23D4A.4010708@free.fr> <40B34946.9030500@g-house.de> <40B34C35.3090303@ru.mvista.com>
In-Reply-To: <40B34C35.3090303@ru.mvista.com>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eugeny S. Mints wrote:
| Christian Kujau wrote:
|
| baptiste coudurier schrieb:
| | Does anyone know what are major/minors for hdu, hdv, hdw, hdx ?
|
| not being a professional, i see:
|
| evil@sheep:~$ la /dev/hd?
| brw-rw----    1 root     disk       3,   0 2004-03-10 11:33 /dev/hda
| brw-rw----    1 root     disk       3,  64 2004-03-10 11:33 /dev/hdb
| brw-rw----    1 root     disk      22,   0 2004-03-10 11:33 /dev/hdc
| brw-rw----    1 root     disk      22,  64 2004-03-10 11:33 /dev/hdd
| brw-rw----    1 root     disk      33,   0 2004-03-10 11:40 /dev/hde
| brw-rw----    1 root     disk      33,  64 2004-03-10 11:40 /dev/hdf
| brw-rw----    1 root     disk      34,   0 2004-03-10 11:40 /dev/hdg
| brw-rw----    1 root     disk      34,  64 2004-03-10 11:40 /dev/hdh
|
| so, it's a major number for every controller (e.g. "22" for hdc+hdd each
| belonging to one controller). hdi+hdj would be major 35, minor [0|64] ?
| i'd try this out for hdx and further...
|
|
|> afaik even the 2.6.x kernel defines only 10 major numbers for IDE
|> devices (from 0 upto 9). All are predefined - see include/linux/major.h
|
|
| did you try devfs/udev? perhaps it could solve this by itsself....?
|
| Christian.
|
| PS: maybe Documentation/devices.txt helps out too.
|
| --
| BOFH excuse #75:
|
| There isn't any problem

I finally patched the kernel sucessfully, adding some new major numbers

Everything seems to work fine execpt for hdparm yet. Im still working on it.
I can supply a patch if anyone is interested.
Thks for your help

- --
Baptiste Coudurier					UIN : 1980693
Debian GNU/Linux user			          ESF Courchevel 1850
GnuPG fp: 8D77 134D 20CC 9220 201F:C5DB 0AC9 325C 5C1A BAAA
checking for life_signs in -lKenny... no
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQCVAwUBQLNPHgrJMlxcGrqqAQLM4gQAlbHpflsWyuwssE4SoWn5QqteJfetM/bE
v1YYEtEDbeIlceOMxpH53mwoFv2w0bLiE3dqoiG2NA4o7yA7v+DJq6s599rwmR8o
KhQYAt/kzMpgzUBPK9Q1qZRKFppM16EwwwKqoehK1z9vAd99Opnm6/Zo8LjYibh1
YYsNtowc6gE=
=VcMI
-----END PGP SIGNATURE-----
