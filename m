Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbUCIWHA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 17:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbUCIWGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 17:06:46 -0500
Received: from fep22-0.kolumbus.fi ([193.229.0.60]:64403 "EHLO
	fep22-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S261427AbUCIWGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 17:06:37 -0500
Message-ID: <404E4006.5020604@helsinki.fi>
Date: Wed, 10 Mar 2004 00:07:02 +0200
From: Kliment Yanev <Kliment.Yanev@helsinki.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040222
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Nokia c110 driver
References: <40419A1C.5070103@helsinki.fi> <20040301101706.3a606d35.rddunlap@osdl.org> <404C8A35.3020308@helsinki.fi> <20040308090640.2d557f9e.rddunlap@osdl.org> <404CF77A.2050301@helsinki.fi> <20040308150907.4db68831.rddunlap@osdl.org> <404D0032.1000807@helsinki.fi> <20040308153602.331f079e.rddunlap@osdl.org> <404DC622.7020300@helsinki.fi> <20040309080409.49fc0358.rddunlap@osdl.org> <20040309192713.GA2182@mars.ravnborg.org>
In-Reply-To: <20040309192713.GA2182@mars.ravnborg.org>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Sam Ravnborg wrote:
|
| The above files are normal .o files, that should be linked in.
| So what you do is to rename the above files to:
| dhw.o_shipped
| dap.o_shipped
| dmgr.o_shipped
| dcfg.o_shipped
|
| And then in your makefile specify:
|
| obj-m	:= cs110.o
| cs110-y := dhw.o dap.o dmgr.o dcfg.o
| cs110-y += <additional .o files compield from .c files>
|

It compiled, finally. I have not been able to convince it to create a
device though, but the driver at least loads. Has anything changed in
the handling of netdevices between 2.4 and 2.6 that could cause this
behavior? That is, the pcmcia tools notice the card and load the module,
but then nothing else happens (module usecount 0, no netdevice present)

Is there some kbuild howto somewhere? If not, one is definitely
necessary I think. I had never heard about the _shipped thing (and I did
look around a bit and read and reread the driver porting guide chapter
on kbuild).

Now, is there anyone else that is in possession of this card and can
test the modified driver? I will try and make a patch tomorrow...a lot
of changes were needed and I think it's pretty messy (I am not an
experienced c person) but at least it compiles and loads now.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFATkAFrPQTyNB9u9YRAiNYAJ0XUOMwXrsdfUSwyXARUD0om7B4hQCfQO6N
a+0rrABQO8+/Sp1RWEfUIY4=
=vziv
-----END PGP SIGNATURE-----
