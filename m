Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265889AbUGEBuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265889AbUGEBuq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 21:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265898AbUGEBuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 21:50:46 -0400
Received: from smtp3.cwidc.net ([154.33.63.113]:62670 "EHLO smtp3.cwidc.net")
	by vger.kernel.org with ESMTP id S265889AbUGEBuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 21:50:44 -0400
Message-ID: <40E8B3DB.5010402@tequila.co.jp>
Date: Mon, 05 Jul 2004 10:50:19 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040308
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org, olaf+list.linux-kernel@olafdietsche.de
Subject: Re: procfs permissions on 2.6.x
References: <20040703202242.GA31656@MAIL.13thfloor.at> <20040703202541.GA11398@infradead.org> <20040703133556.44b70d60.akpm@osdl.org> <20040703210407.GA11773@infradead.org> <20040703143558.5f2c06d6.akpm@osdl.org> <20040704213527.GV12308@parcelfarce.linux.theplanet.co.uk> <20040704145542.4d1723f5.akpm@osdl.org> <20040704221302.GW12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040704221302.GW12308@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

viro@parcelfarce.linux.theplanet.co.uk wrote:
| On Sun, Jul 04, 2004 at 02:55:42PM -0700, Andrew Morton wrote:
|
|>Some do.  On my test box 1000-odd /proc inodes get allocated and fully
|>freed on each `ls -R /proc'.  65 /proc inodes are freed during `ls -lR
|>/proc/net'.  So maybe it isn't working completely.
|>
|>But proc_notify_change() copies the inode's uid, gid and mode into the
|>proc_dir_entry, so they get correctly initialised when the inode is
|>reinstantiated, so afaict we have no bug here.
|
|
| Why on the earth do we ever want to allow chown/chmod on procfs in the
first
| place?

Well perhaps I am on the wrong track but eg /proc/bus/usb/002/005 is my
digital camera and unless its either world rw or owned by me (user) I
can't get any pictures unless I make myself root.

So yes, I would want to have chown/chmod in procfs ...

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA6LPajBz/yQjBxz8RApbcAKCfmBwm92UmiAqOZvEtZq6M215XKACg4Tbl
oF+mx5LOEd9QMrrVomg+lOY=
=qvWj
-----END PGP SIGNATURE-----
