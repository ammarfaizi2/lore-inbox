Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbUCHXWZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUCHXWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:22:25 -0500
Received: from fep21-0.kolumbus.fi ([193.229.0.48]:20467 "EHLO
	fep21-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S261407AbUCHXWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:22:14 -0500
Message-ID: <404D0032.1000807@helsinki.fi>
Date: Tue, 09 Mar 2004 01:22:26 +0200
From: Kliment Yanev <Kliment.Yanev@helsinki.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040222
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Nokia c110 driver
References: <40408852.8040608@helsinki.fi>	<20040228104105.5a699d32.rddunlap@osdl.org>	<40419A1C.5070103@helsinki.fi>	<20040301101706.3a606d35.rddunlap@osdl.org>	<404C8A35.3020308@helsinki.fi>	<20040308090640.2d557f9e.rddunlap@osdl.org>	<404CF77A.2050301@helsinki.fi> <20040308150907.4db68831.rddunlap@osdl.org>
In-Reply-To: <20040308150907.4db68831.rddunlap@osdl.org>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Randy.Dunlap wrote:

|
| I have no idea where these symbols live or come from.

I found them! they are in the binary-only part of the driver but for
some reason they are not getting linked into the .ko file. I tried
linking them manually but then I get an "invalid module format"

|
| You know, it's possible that you could purchase a card that already
| works on Linux 2.6.... that might be a better solution than trying
| to use an unknown binary module.

At this point I am doing this just to see if it will work... I don't
need the card for another week or so and if I don't get this one to work
I'll just buy another one. Yet I have the feeling that this card will
work before long... if only I could get those files linked that is...

My makefile (dhw, dap, dmgr and dcfg are in the binary parts, present in
the current dir as dhw.o etc.; all the others are .c files that get
compiled during a make):

~    ifneq ($(KERNELRELEASE),)
~    obj-m       := nokia_c110.o
~    module-objs := dllc.o dtools.o dhw.o dap.o dmgr.o dcfg.o

~    else
~    KDIR        := /lib/modules/$(shell uname -r)/build
~    PWD         := $(shell pwd)

~    default:
~        $(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
~    endif


|

Thanks for all your help so far.

Kliment
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFATQAyrPQTyNB9u9YRAul8AKCgtRfIC65TDVxGNdsyZtnD9mMOKQCgl7Pe
qhYXJJggGUVYzNjBdN3tphU=
=/fei
-----END PGP SIGNATURE-----
